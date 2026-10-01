# PCB da trackball — PMW3360 rev 2.0c

## Projeto e arquivos usados

Projeto oficial: [BastardKB/charybdis-pmw-3360-sensor-pcb](https://github.com/Bastardkb/charybdis-pmw-3360-sensor-pcb)

Release correta: [2.0c](https://github.com/Bastardkb/charybdis-pmw-3360-sensor-pcb/releases/tag/2.0c)

Arquivos exatos utilizados no pedido:

- Gerber: [`sensor_2.0c.zip`](https://github.com/Bastardkb/charybdis-pmw-3360-sensor-pcb/releases/download/2.0c/sensor_2.0c.zip)
- BOM: [`bom.csv`](https://github.com/Bastardkb/charybdis-pmw-3360-sensor-pcb/releases/download/2.0c/bom.csv)
- Positions/CPL: [`positions.csv`](https://github.com/Bastardkb/charybdis-pmw-3360-sensor-pcb/releases/download/2.0c/positions.csv)

Os arquivos de fabricação não foram copiados para este repositório; use os assets da release oficial indicada.

## Alerta sobre o Gerber

**Não use como Gerber desta build `sensor/jlcpcb/production_files/GERBER-sensor.zip`.** Durante a preparação do pedido, esse pacote antigo foi conferido e renderizava **REV 1.8**. Com o BOM/CPL 2.0c, os componentes apareciam visualmente deslocados. O pedido foi interrompido antes da fabricação. A correção foi usar o asset `sensor_2.0c.zip` da release oficial 2.0c.

Antes de pagar, o preview final do pedido com o Gerber correto foi revisado; os overlays dos componentes estavam alinhados com os pads.

## Configuração registrada do pedido JLCPCB

**PCB**

- FR-4, 2 layers, espessura 1,6 mm, cobre 1 oz.
- Máscara verde e serigrafia branca.
- HASL.
- Quantidade: 5 PCBs.

**PCBA**

- Economic PCBA, Bottom Side.
- Quantidade: 2 placas montadas.
- Parts Selection / Self-Service.
- A montagem automática inclui os componentes SMD selecionados no BOM/CPL.

Itens deliberadamente fora da montagem de fábrica:

- **U1001 — PMW3360DM-T2QU:** será comprado e montado separadamente; não incluso na PCBA.
- **J1001 — header 1 × 06, 2,54 mm:** não precisa ser montado pela fábrica.
- **J1002 — conector FPC:** não selecionado, pois a build é handwire e não usa o flex correspondente.
- **LM19-LSI:** lente óptica/mecânica, será comprada separadamente.

O pedido foi pago. Valores finais e totais por moeda estão em [purchases.md](purchases.md).
