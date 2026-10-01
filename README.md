# Charybdis Nano 3x5 — documentação da build

Este repositório registra a construção completa de um Charybdis Nano 3x5: arquivos de impressão, arquitetura eletrônica, compras, montagem e configuração. A build é handwire, usa dois RP2040-Zero e QMK, e terá trackball óptico PMW3360 de 34 mm.

## Fluxo da build

**IMPRIMIR → COMPRAR → SOLDAR → MONTAR → CONFIGURAR QMK → USAR**

## Estrutura

- `01_cases/` — cases das duas metades.
- `02_bottom_plates/` — placas inferiores.
- `03_trackball/` — peças do conjunto da trackball.
- `04_tenting/` — peças para inclinação.
- `05_keycaps/` — coupon e conjunto de keycaps.
- `06_electronics/` — arquitetura, BOM, PCB do sensor e registro de compras.

> **Atenção:** os arquivos `LEFT` já estão espelhados. **Não espelhe novamente no slicer.** Há 11 modelos de impressão atualmente no repositório.

## Keycaps

O procedimento recomendado para builds em geral continua sendo imprimir primeiro `05_keycaps/MX_stem_fit_coupon.stl`, testar em um switch MX e só então imprimir `05_keycaps/full_set_35.3mf`.

Nesta build, Marcelo decidiu conscientemente imprimir o conjunto completo de uma vez porque o custo total da impressão é baixo. Se o encaixe exigir, os keycaps serão recalibrados e reimpressos. Essa é uma decisão específica desta build, não uma mudança na recomendação geral.

O conjunto tem quatro perfis ergonômicos, que não devem ser tratados como um único perfil: 10 top, 10 home, 10 bottom e 5 thumb.

## Eletrônica e andamento

A pasta [`06_electronics/`](06_electronics/README.md) documenta a arquitetura escolhida, a BOM viva, a placa PMW3360 rev 2.0c e os gastos confirmados. A ligação entre as metades ainda é uma hipótese: protocolo QMK split, pinout e quantidade de condutores precisam ser validados antes da soldagem final.

## Licenças

Créditos, origens conhecidas e termos das geometrias de terceiros estão em [`THIRD_PARTY_LICENSES.md`](THIRD_PARTY_LICENSES.md). As licenças aplicáveis continuam válidas.
