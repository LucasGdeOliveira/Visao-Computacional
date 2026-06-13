# Sistema de Inspecao Visual de Frutas

Projeto final de Visao Computacional para o cenario A do enunciado:
**inspecao de frutas em uma central de distribuicao**.

O objetivo e classificar macas em duas classes:

- `fresh`: maca fresca/apta
- `rotten`: maca podre/fora de padrao

O pipeline implementado segue a abordagem classica pedida no PDF:

```text
imagem RGB
  -> segmentacao / isolamento da fruta
  -> extracao de features manuais
  -> tabela X.csv
  -> vetor y.csv
  -> classificadores classicos
  -> avaliacao com metricas e graficos
```

## Dataset Utilizado

O projeto usa imagens reais do dataset:

[Fruits fresh and rotten for classification - Kaggle](https://www.kaggle.com/datasets/sriramr/fruits-fresh-and-rotten-for-classification)

Foram usadas somente as classes de macas:

- `freshapples`
- `rottenapples`

Para manter o projeto balanceado e leve, foram selecionadas:

- 300 imagens em `dataset/fresh`
- 300 imagens em `dataset/rotten`
- 600 imagens no total

Essa quantidade atende ao requisito do PDF, que pede pelo menos 100 imagens por classe.

## Estrutura do Projeto

```text
projeto/
  dataset/
    fresh/                  imagens reais de macas frescas
    rotten/                 imagens reais de macas podres

  notebooks/
    01_segmentacao.ipynb    compara Otsu/Saturacao e Watershed
    02_features.ipynb       extrai features e gera X.csv / y.csv
    03_classificacao.ipynb  treina Random Forest e SVM

  outputs/
    figuras/                graficos de segmentacao, features, ROC e importancia
    matrizes/               matrizes de confusao
    tabelas/                metricas e medias por classe
    erros/                  exemplos de classificacoes incorretas

  X.csv                     tabela final de features
  y.csv                     rotulos das imagens
  segmentacao_utils.py      funcao de segmentacao usada pelos notebooks
  executar_pipeline.ps1     script para executar tudo automaticamente
  requirements.txt          dependencias do projeto
```

## Arquivos Que Nao Sobem Para o GitHub

Algumas pastas sao criadas localmente para executar o projeto, mas nao devem ser
enviadas ao GitHub porque deixam o repositorio pesado ou sao apenas cache:

```text
.venv/
.ipython/
.jupyter/
.matplotlib/
__pycache__/
.ipynb_checkpoints/
```

Essas pastas estao no `.gitignore`.

Quando outra pessoa baixar o projeto, ela deve recriar o ambiente virtual e
instalar as dependencias novamente. Isso e o normal em projetos Python.

## Como Instalar e Rodar

Os comandos abaixo devem ser executados no PowerShell, dentro da pasta do projeto:

```powershell
cd "C:\Users\gomes\Downloads\projeto_inspecao_frutas\projeto"
```

### 1. Criar ambiente virtual

```powershell
python -m venv .venv
```

Se o comando `python` nao estiver disponivel, instale o Python ou selecione um
interpretador Python pelo VS Code.

### 2. Ativar o ambiente virtual

```powershell
.\.venv\Scripts\Activate.ps1
```

Quando estiver ativo, o terminal deve mostrar `(.venv)` no inicio da linha.

Se o PowerShell bloquear a ativacao, rode antes:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
```

Depois tente ativar novamente:

```powershell
.\.venv\Scripts\Activate.ps1
```

### 3. Instalar dependencias

```powershell
pip install -r requirements.txt
```

### 4. Rodar o pipeline completo

```powershell
powershell -ExecutionPolicy Bypass -File .\executar_pipeline.ps1
```

Esse script executa automaticamente:

```text
01_segmentacao.ipynb
02_features.ipynb
03_classificacao.ipynb
```

Ao final, os arquivos em `outputs/`, `X.csv` e `y.csv` sao regenerados.

## Como Rodar Pelo VS Code

1. Abra o VS Code.
2. Clique em `File > Open Folder`.
3. Selecione a pasta:

```text
C:\Users\gomes\Downloads\projeto_inspecao_frutas\projeto
```

4. Abra o terminal integrado.
5. Ative o ambiente:

```powershell
.\.venv\Scripts\Activate.ps1
```

6. Registre o kernel do notebook:

```powershell
python -m ipykernel install --user --name projeto-frutas --display-name "Projeto Frutas (.venv)"
```

7. Abra os notebooks em `notebooks/`.
8. No canto superior direito, selecione o kernel:

```text
Projeto Frutas (.venv)
```

9. Execute os notebooks nesta ordem:

```text
01_segmentacao.ipynb
02_features.ipynb
03_classificacao.ipynb
```

## Resultados Atuais

Com 300 imagens por classe, os resultados finais foram:

| Modelo        | Acuracia | Precisao | Recall | F1-score |
|---------------|----------|----------|--------|----------|
| Random Forest | 0.9750   | 0.9672   | 0.9833 | 0.9752   |
| SVM           | 0.9750   | 0.9672   | 0.9833 | 0.9752   |

Os resultados estao salvos em:

```text
outputs/tabelas/tabela_metricas.csv
```

## Principais Saidas Geradas

```text
outputs/figuras/comparacao_segmentacao.png
outputs/figuras/boxplots_features.png
outputs/figuras/distribuicoes_top_features.png
outputs/figuras/importancia_features.png
outputs/figuras/curva_roc.png
outputs/matrizes/matrizes_confusao.png
outputs/erros/exemplos_erros.png
outputs/tabelas/tabela_metricas.csv
outputs/tabelas/medias_por_classe.csv
```

## Tecnicas Implementadas

- Segmentacao por Otsu no canal de saturacao HSV
- Comparacao com Watershed
- Features de forma
- Momentos de Hu
- Features de cor RGB e HSV
- Features de textura com GLCM e LBP
- Random Forest
- SVM
- Split estratificado treino / validacao / teste
- `StandardScaler` ajustado apenas no treino
- `GridSearchCV` com validacao cruzada
- Matriz de confusao
- Curva ROC
- Analise de importancia de features
- Analise de erros

## Observacao

O projeto ja contem o dataset final em `dataset/`, os arquivos `X.csv` e `y.csv`
e as saidas em `outputs/`. Mesmo assim, o pipeline pode ser executado novamente
a qualquer momento usando `executar_pipeline.ps1`.
