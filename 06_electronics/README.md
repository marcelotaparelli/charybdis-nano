# Eletrônica — Charybdis Nano 3x5

## Arquitetura escolhida

- Charybdis Nano 3x5, handwire, com switches MX e diodos through-hole 1N4148.
- Dois controladores RP2040-Zero com USB-C, um por metade, usando QMK.
- Sensor óptico PMW3360DM-T2QU com lente LM19-LSI e trackball de 34 mm.
- Três rolamentos MR63ZZ de 3 × 6 × 2,5 mm.
- Sem RGB, key flex PCBs, thumb flex PCB, Splinky ou Splinktegrated.

O handwire foi escolhido para dispensar PCBs flexíveis de matriz e permitir a montagem direta dos switches, diodos e controladores. A placa dedicada do sensor PMW3360 continua sendo usada. O pedido de fabricação dessa placa e sua montagem SMD estão descritos em [trackball-pcb.md](trackball-pcb.md).

## Controladores

São usados dois RP2040-Zero USB-C, um em cada metade. O holder do RP2040-Zero ainda não está resolvido; nenhum STL de holder foi definido. Antes de desenhar ou fabricar um adaptador, devem ser validados:

1. Dimensões reais do RP2040-Zero recebido.
2. Espaço interno disponível nos cases.
3. Pontos de montagem existentes.
4. Acesso e orientação do USB-C.
5. Folga para fios e solda.

A preferência futura é por um pequeno holder/adaptador independente, sem modificar os STLs originais dos cases.

## Ligação entre as metades

A intenção atual é evitar TRRS na primeira build e usar uma ligação fixa simples. **VCC + GND + DATA é apenas uma hipótese atual, não uma solução elétrica fechada ou validada.** O protocolo QMK split, o pinout e a quantidade de condutores ainda precisam ser definidos e validados antes da soldagem final. A interligação entre as metades ainda não foi testada eletricamente.

## Próximas etapas físicas

1. Receber e inspecionar a impressão.
2. Comprar os componentes restantes.
3. Receber as PCBs PMW3360.
4. Validar os encaixes.
5. Resolver o holder do RP2040-Zero.
6. Fazer o handwire da matriz.
7. Montar o sensor e a trackball.
8. Configurar QMK.

Consulte a [BOM viva](bom.md) para itens e status e o [registro de compras](purchases.md) para valores efetivamente pagos.
