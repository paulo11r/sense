# Sentir & Jogar

<p align="left">
  <img src="https://skillicons.dev/icons?i=godot,figma,git,github" alt="Godot, Figma, Git, GitHub" />
</p>

Projeto acadêmico (A3) desenvolvido no Centro Universitário UniFG (Guanambi), a partir de uma proposta do curso de Enfermagem voltada ao atendimento e à interação com crianças em UBS (Unidades Básicas de Saúde), incluindo situações envolvendo crianças neurodivergentes ou com dificuldades de comunicação.

A proposta original da Enfermagem utiliza uma tábua sensorial e um boneco com dois rostos (feliz e triste), que ajudam a criança a expressar sentimentos ou indicar onde sente desconforto ou dor, facilitando a comunicação quando verbalizar não é simples. O desafio do projeto é criar uma experiência digital que dialogue com essa proposta, ampliando-a por meio da tecnologia.

O Sentir & Jogar é a nossa interpretação desse desafio: uma experiência interativa que leva essa dinâmica de expressão de sentimentos para o digital, com foco em acessibilidade (modo sonoro/cego) e pensada para rodar também em celular.

## Tecnologias utilizadas

- **Godot Engine** — engine de jogos escolhida para o desenvolvimento, permitindo exportação para múltiplas plataformas (desktop e mobile)
- **GDScript** — linguagem utilizada na lógica do jogo
- **Figma** — prototipação e definição das telas
- **Git / GitHub** — versionamento e colaboração

## Plataformas

O projeto é multiplataforma e foi testado em **Android**, via exportação nativa do Godot.

## Baixar e instalar no celular (Android)

A forma mais rápida de testar o app é instalando o APK, sem precisar do Godot:

1. Acesse a aba [**Releases**](https://github.com/paulo11r/sense/releases) deste repositório.
2. Baixe o arquivo `Sentir-e-jogar.apk` da versão mais recente.
3. Abra o arquivo no celular e instale. Se o Android avisar sobre "fontes desconhecidas", autorize a instalação.

> Requer Android 10 ou superior.

## Rodar o projeto a partir do código

Para abrir, editar ou gerar o APK por conta própria:

1. Instale o [Godot Engine](https://godotengine.org/download) na versão **4.7.2 (stable)**.
2. Clone este repositório:
   ```
   git clone https://github.com/paulo11r/sense.git
   ```
3. Abra o Godot, clique em **Importar** e selecione o arquivo `project.godot` da pasta clonada.

### Gerar o APK

1. **Templates de exportação:** em **Editor > Gerenciar Modelos de Exportação**, ative o acesso online e baixe os templates da versão 4.7.2 (basta o de Android).
2. **Java (JDK):** instale o JDK 17 ou superior e, em **Editor > Configurações do Editor > Exportação > Android**, aponte o **Caminho do SDK Java** para a pasta do JDK.
3. **Android SDK:** na mesma tela, confira se o **Caminho do SDK Android** está preenchido.
4. **Compressão de texturas:** em **Configurações do Projeto** (com Configurações Avançadas ligado), vá em **Renderização > Texturas** e ative **Import ETC2 ASTC**.
5. Vá em **Projeto > Exportar**, adicione o preset **Android**, deixe apenas a arquitetura **arm64-v8a** marcada e defina o **Export Path** com o nome do arquivo terminado em `.apk`.
6. Clique em **Exportar Projeto**. O arquivo `.apk` gerado é o que se instala no celular (o `.idsig` que aparece junto pode ser ignorado).

### Rodar direto no celular, sem gerar APK

Ative a **Depuração USB** nas Opções do Desenvolvedor do Android, conecte o celular ao PC e clique no ícone de celular na barra de execução do Godot.

## Colaboradores

- Gabriel Normanha Reis
- Paulo Henrique de Souza Rocha
