# Flappy Chaos

## Visão Geral

**Flappy Chaos** é uma versão caótica e reimaginada do clássico Flappy Bird, desenvolvida em **Lua** utilizando o framework **LÖVE 2D**. O jogo desafia o jogador a desviar de obstáculos enquanto lida com modificadores de jogabilidade que alteram as regras do jogo em tempo real.

## 🎮 Como Jogar

O objetivo é simples: sobreviva o maior tempo possível passando por entre obstáculos. No entanto, o "caos" pode ser ativado a qualquer momento!

### Controles

| Tecla | Ação |
| :--- | :--- |
| **Espaço** | Pular (ou cair, se a gravidade estiver invertida) |
| **1(teste)** | Ativa **Gravidade Invertida** (5 segundos) |
| **2(teste)** | Ativa **Tela Invertida** (Gira a tela em 180°) (5 segundos) |
| **3(teste)** | Ativa **Modo Gigante** (Aumenta o tamanho do jogador) (5 segundos) |

## ✨ Funcionalidades

*   **Sistema de Gravidade:** Física realista de queda e pulo.
*   **Modificadores de Caos:** Três efeitos únicos que mudam drasticamente a percepção e a dificuldade.
*   **Geração Infinita:** Canos gerados proceduralmente com alturas aleatórias.
*   **Detecção de Colisão:** Sistema preciso de colisão entre o jogador e os obstáculos.

## 📁 Estrutura da Pasta

```
Flappy-Chaos/
├── assets/
│   └── images/
│       └── bomba.png   # Sprite do jogador
├── main.lua            # Lógica principal do jogo
└── README.md
```

## 🚀 Execução

Certifique-se de ter o **LÖVE 2D** instalado. Navegue até a pasta do jogo e execute:

```bash
love .
```
VS Code

```bash
Alt + L
```