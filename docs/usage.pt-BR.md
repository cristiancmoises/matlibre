# Uso do MatLibre

## Carregar a integração

Após instalar pelo Guix, adicione `(require 'matlivre)` ao init do Emacs.
Se o seu Emacs não descobrir os pacotes do perfil, adicione o diretório
`share/emacs/site-lisp/matlibre-0.1.0` do perfil ao `load-path`.
Na instalação manual:

```elisp
(add-to-list 'load-path "/caminho/do/matlibre/lisp")
(require 'matlivre)
```

Use `M-x matlibre` tanto no Emacs gráfico quanto em `emacs -nw`.
`matlivre-program` indica o executável; o valor padrão é `matlivre`.

## Editar e executar

Ative `M-x matlivre-script-mode` em um buffer de código `.m`.
`C-c C-c` executa o buffer inteiro; `C-c C-r` executa a seleção.
Nenhum desses comandos exige salvar o arquivo. O workspace é compartilhado
entre execuções enquanto a conexão estiver aberta.

`C-c C-w` consulta as variáveis. `C-c C-z` abre os resultados. Nesse buffer,
`e` avalia uma expressão, `w` consulta o workspace, `t` abre a lista de
ferramentas e `k` desconecta. Erros de execução aparecem nos resultados.
O limite padrão por requisição é 120 segundos (`matlivre-timeout`); ao exceder
o limite, a conexão é encerrada para evitar respostas fora de sequência.

## Gráficos e documentos

O Emacs gráfico exibe as imagens PNG retornadas pelo MatLivre. No terminal,
um botão permite salvar a imagem no caminho escolhido por você.
O arquivo `examples/waves.m` demonstra um gráfico simples.

`C-c C-o` abre um documento na janela nativa do MatLivre, inclusive `.mlx`.
Essa janela fica separada do frame do Emacs. A integração não reescreve
arquivos `.mlx` nem os trata como código-fonte simples.

O próprio MatLivre conecta sua interface stdio a uma janela já aberta.
Na ausência dela, usa um interpretador sem janela. Depois de abrir ou fechar
a janela nativa, execute `matlivre-stop` antes de reconectar. A sessão sem
janela oferece `run_code` e `get_workspace`; a janela aberta também oferece
ferramentas de leitura e edição de documentos. `M-x matlivre-tool` descobre as
ferramentas e recebe seus argumentos em JSON.

## Diretórios e segurança

O código usa as permissões da sua conta. Execute somente scripts confiáveis.
A conexão começa no `default-directory` do buffer que a iniciou; use `cd`
quando precisar acessar arquivos relativos em outro diretório.
A integração não executa processos remotos por TRAMP.
