#!/usr/bin/env node
// Binary STL reflection: negate X, reverse winding, and reflect stored normals.
// No vertex coordinates are recalculated or quantized beyond the X sign change.
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const pairs = [
  ['01_cases/LEFT_SOURCE_case_v4_103_MIRROR_IN_SLICER.stl', '01_cases/LEFT_case_v4_103.stl'],
  ['02_bottom_plates/LEFT_SOURCE_plate_v4_103_MIRROR_IN_SLICER.stl', '02_bottom_plates/LEFT_plate_v4_103.stl'],
  ['04_tenting/LEFT_SOURCE_tent15deg_v2_27_MIRROR_IN_SLICER.stl', '04_tenting/LEFT_tent15deg_v2_27.stl'],
];

function load(name) {
  const data = fs.readFileSync(path.join(root, name));
  if (data.length < 84) throw new Error(`${name}: STL too short`);
  const count = data.readUInt32LE(80);
  if (data.length !== 84 + count * 50) throw new Error(`${name}: invalid binary STL length`);
  return { data, count };
}

function flipSign(data, offset) {
  // IEEE-754 float32 sign bit: exact reflection, including subnormal values.
  data.writeUInt32LE((data.readUInt32LE(offset) ^ 0x80000000) >>> 0, offset);
}

function mirror(source) {
  const out = Buffer.from(source);
  const scratch = Buffer.alloc(12);
  for (let offset = 84; offset < out.length; offset += 50) {
    flipSign(out, offset); // stored normal X
    for (const vertex of [12, 24, 36]) flipSign(out, offset + vertex);
    // Reflection reverses handedness; exchange vertices 2 and 3 to restore it.
    out.copy(scratch, 0, offset + 24, offset + 36);
    out.copy(out, offset + 24, offset + 36, offset + 48);
    scratch.copy(out, offset + 36);
  }
  return out;
}

function signedVolumeAndBounds(data) {
  const min = [Infinity, Infinity, Infinity];
  const max = [-Infinity, -Infinity, -Infinity];
  let volume6 = 0;
  for (let offset = 84; offset < data.length; offset += 50) {
    const v = [];
    for (let j = 0; j < 3; j++) {
      const p = [];
      for (let k = 0; k < 3; k++) {
        const n = data.readFloatLE(offset + 12 + j * 12 + k * 4);
        if (!Number.isFinite(n)) throw new Error('Non-finite vertex');
        p.push(n);
        min[k] = Math.min(min[k], n);
        max[k] = Math.max(max[k], n);
      }
      v.push(p);
    }
    volume6 += v[0][0] * (v[1][1] * v[2][2] - v[1][2] * v[2][1])
      + v[0][1] * (v[1][2] * v[2][0] - v[1][0] * v[2][2])
      + v[0][2] * (v[1][0] * v[2][1] - v[1][1] * v[2][0]);
  }
  return { bounds: [min, max], dimensions: max.map((n, i) => n - min[i]), volume: volume6 / 6 };
}

function componentCount(data) {
  // STL is a triangle soup. Join faces sharing an entire geometric edge.
  const parent = [];
  const edges = new Map();
  function find(i) { while (parent[i] !== i) { parent[i] = parent[parent[i]]; i = parent[i]; } return i; }
  function unite(a, b) { a = find(a); b = find(b); if (a !== b) parent[b] = a; }
  for (let offset = 84; offset < data.length; offset += 50) {
    const face = parent.length;
    parent.push(face);
    const keys = [];
    for (let j = 0; j < 3; j++) {
      const coords = [];
      for (let k = 0; k < 3; k++) coords.push(data.readFloatLE(offset + 12 + j * 12 + k * 4));
      keys.push(coords.join(','));
    }
    for (const [j, k] of [[0, 1], [1, 2], [2, 0]]) {
      const edge = [keys[j], keys[k]].sort().join('|');
      if (edges.has(edge)) unite(face, edges.get(edge));
      else edges.set(edge, face);
    }
  }
  return new Set(parent.map((_, i) => find(i))).size;
}

function validate(sourceName, resultName) {
  const a = load(sourceName), b = load(resultName);
  if (a.count !== b.count) throw new Error(`${resultName}: triangle count changed`);
  if (!mirror(a.data).equals(b.data)) throw new Error(`${resultName}: reflection differs from -1/1/1 plus corrected winding/normals`);
  const ma = signedVolumeAndBounds(a.data), mb = signedVolumeAndBounds(b.data);
  const same = (x, y) => Math.abs(x - y) <= 1e-9 * Math.max(1, Math.abs(x), Math.abs(y));
  for (let k = 0; k < 3; k++) {
    if (!same(ma.dimensions[k], mb.dimensions[k])) throw new Error(`${resultName}: dimensions changed`);
    if (!same(ma.bounds[0][k], k === 0 ? -mb.bounds[1][0] : mb.bounds[0][k])) throw new Error(`${resultName}: bounding box changed`);
    if (!same(ma.bounds[1][k], k === 0 ? -mb.bounds[0][0] : mb.bounds[1][k])) throw new Error(`${resultName}: bounding box changed`);
  }
  if (!same(Math.abs(ma.volume), Math.abs(mb.volume))) throw new Error(`${resultName}: volume changed`);
  if (!same(ma.volume, mb.volume)) throw new Error(`${resultName}: face orientation changed`);
  const ca = componentCount(a.data), cb = componentCount(b.data);
  if (ca !== cb) throw new Error(`${resultName}: component count changed`);
  console.log(`${sourceName} -> ${resultName}: triangles=${a.count}, dimensions=${ma.dimensions.join(' x ')}, |volume|=${Math.abs(ma.volume).toFixed(6)}, components=${ca}, exact X reflection=OK`);
}

for (const [sourceName, resultName] of pairs) {
  const source = load(sourceName);
  if (process.argv.includes('--write')) fs.writeFileSync(path.join(root, resultName), mirror(source.data));
  validate(sourceName, resultName);
}
