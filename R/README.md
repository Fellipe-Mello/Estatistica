# Estatística e Visualização de Dados em R

Esta pasta reúne **scripts em R com métodos estatísticos e gráficos** usados em análises de dados ambientais e de solos, como atributos do solo, índices de saúde do solo, sensoriamento remoto e bibliometria. Os scripts cobrem:

- **Análise exploratória**: estatísticas descritivas, assimetria, boxplots e histogramas
- **Estatística multivariada**: Análise de Componentes Principais (PCA) e matrizes de correlação
- **Avaliação de modelos preditivos**: R², RMSE e RPIQ, além da divisão de dados em calibração e validação
- **Manipulação de dados**: junção de tabelas (*merge*) e tratamento de valores ausentes em rasters
- **Visualização para publicação**: barras empilhadas, barras horizontais, gráficos com eixo duplo, radar, triângulo textural e importância de variáveis, exportados em TIFF, PNG ou EMF de alta resolução

Cada script é independente (com uma exceção, veja `Bar-Graph-Breaks2.R`) e foi pensado como um **modelo**: troque o diretório, o arquivo de entrada e os nomes das colunas para usá-lo com seus próprios dados.

---

## Sumário

1. [Estrutura da pasta](#estrutura-da-pasta)
2. [Descrição dos scripts](#descrição-dos-scripts)
   - [Análise exploratória](#1-análise-exploratória)
   - [Estatística multivariada (PCA e correlação)](#2-estatística-multivariada-pca-e-correlação)
   - [Avaliação de modelos e divisão de dados](#3-avaliação-de-modelos-e-divisão-de-dados)
   - [Manipulação de dados](#4-manipulação-de-dados)
   - [Gráficos](#5-gráficos)
3. [Pacotes necessários](#pacotes-necessários)
4. [Como executar](#como-executar)
5. [Formato dos dados de entrada](#formato-dos-dados-de-entrada)
6. [Pontos de atenção](#pontos-de-atenção)

---

## Estrutura da pasta

| Script | Categoria | O que faz |
|---|---|---|
| `Exploratory_Analysis.R` | Análise exploratória | Estatísticas descritivas, assimetria, dispersão com regressão e boxplots |
| `Histograma.R` | Análise exploratória | Histogramas de dados de laboratório e de rasters preditos |
| `Boxplot.R` | Análise exploratória | Boxplot agrupado (textura × zona de manejo) |
| `Boxplot-Multiplos.R` | Análise exploratória | Boxplots múltiplos com facetas (versão básica) |
| `Boxplot-Multiplos-2.R` | Análise exploratória | Boxplots múltiplos com facetas e cores personalizadas (versão final) |
| `PCA-SHI.R` | Multivariada | PCA com tabela de autovalores, variância explicada, autovetores e comunalidades |
| `script_PCA.R` | Multivariada | PCA com biplot (scores e loadings) colorido por grupo |
| `script_PCA_2.R` | Multivariada | PCA com três variações de biplot e cores personalizadas |
| `Correlacao.R` | Multivariada | Matriz de correlação de Spearman com `ggcorrplot` |
| `script_matriz_correlacao.R` | Multivariada | Matriz de correlação de Pearson com `corrplot` e paleta personalizada |
| `Regressao_R2_RPIQ_RMSE_Grafico.R` | Modelos | Gráfico observado × predito com R², RMSE e RPIQ |
| `Create_data_partition.R` | Modelos | Divide os dados em calibração (70%) e validação (30%) |
| `Merge_Dataset.R` | Manipulação | Junta duas tabelas por uma coluna em comum (`BLOCO`) |
| `Merge_Dataset_2.R` | Manipulação | *Left join* entre predições e estatísticas zonais (`KEY`) |
| `Merge_two_datasets_with_column_reference.R` | Manipulação | Junta pontos filtrados às covariáveis pela coluna `FID` |
| `Replace_Raster_NA.R` | Manipulação | Substitui valores inválidos e NA de um raster pela mediana |
| `Bar-Graph-Breaks.R` | Gráficos | Barras empilhadas de publicações por ano e país, com eixo X comprimido |
| `Bar-Graph-Breaks2.R` | Gráficos | Variação do anterior, com uma barra "histórica" para os anos até 1999 |
| `Bar-Horizontal.R` | Gráficos | Barras horizontais de média ± erro padrão |
| `Dual_Axis_Plot.R` | Gráficos | Barras + linha com dois eixos Y |
| `Grafico_Radar.R` | Gráficos | Gráfico de radar (*spider chart*) |
| `Textural_Triangle.R` | Gráficos | Triângulo textural do solo (USDA e SiBCS) |
| `Variable_Importance_Graphic.R` | Gráficos | Barras horizontais ordenadas de importância de variáveis |
| `Var-Imp-Axis-Break.R` | Gráficos | Barras ordenadas com quebra no eixo Y |

---

## Descrição dos scripts

### 1. Análise exploratória

#### `Exploratory_Analysis.R`
Faz a análise exploratória inicial de um banco de dados de solo (`Solo_Filtrado_Completo2.csv`).
- Verifica e converte o tipo das variáveis (`sapply(..., class)`, `as.numeric`).
- Cria um gráfico de dispersão com reta de regressão linear (`lm` + `abline`).
- Faz boxplots rápidos de argila, matéria orgânica, areia etc.
- Calcula média, mediana, desvio padrão, `summary()` e **assimetria** (`moments::skewness`).
- Gera um *scatterplot* com `car::scatterplot` e exporta a tabela tratada em CSV.

**Pacotes:** `ggplot2`, `car`, `moments`

#### `Histograma.R`
Gera histogramas para comparar a distribuição de uma variável medida em laboratório com a mesma variável predita em um mapa raster (`M.tif`).
- Histograma sobreposto por grupo com `ggplot2` + `hrbrthemes`.
- Histograma em R base (`hist`), com classes (`breaks`) e limites definidos.
- Converte o raster em *data frame* (`raster::as.data.frame(xy = TRUE)`) para plotar a distribuição dos pixels.
- **Saídas:** `Hist-M-Lab.tif`, `Hist-M-Pred.tif`

**Pacotes:** `ggplot2`, `dplyr`, `hrbrthemes`, `raster`

#### `Boxplot.R`
Boxplot agrupado das frações texturais (Silte, Argila, Areia) por zona de manejo (`ZM`), a partir de `ZM.csv`. Filtra as classes com `subset()` e aplica um tema personalizado (`mynamestheme`).
- **Saída:** `Boxplot_ZM_Textura.tif`

**Pacotes:** `ggplot2`

#### `Boxplot-Multiplos.R` e `Boxplot-Multiplos-2.R`
Boxplots de vários atributos de uma vez, com um painel por atributo (`facet_wrap(~Attribute, scales = "free")`), comparando grupos (`Area` ou `LULC`).
- Os dados precisam estar em **formato longo**, com as colunas `Area`/`LULC`, `Attribute` e `Value`.
- A **versão 2** é a mais completa: define paletas de cores para diferentes conjuntos de tratamentos, fixa a ordem dos grupos e remove os rótulos redundantes do eixo X.
- **Saída (v2):** `Boxplot-RJ.tif` (4000 × 2000 px, 400 dpi)

**Pacotes:** `ggplot2`

---

### 2. Estatística multivariada (PCA e correlação)

#### `PCA-SHI.R`
PCA "numérica", com foco nos resultados usados em tabelas de artigos e na construção de **índices de saúde do solo (SHI)**. Os dados são centralizados e padronizados (`prcomp(scale. = TRUE)`). O script calcula:
1. **Autovalores** (`sdev^2`)
2. **Variância explicada (%)** por componente
3. **Variância acumulada (%)**
4. **Autovetores** (*loadings*, `pca$rotation`)
5. **Comunalidades** (soma dos quadrados dos *loadings*)

No final, monta a tabela `PCA_summary` com PC, autovalor, variância e variância acumulada.

**Pacotes:** apenas R base (`stats`)

#### `script_PCA.R`
PCA com **biplot**, a partir de `RJ.csv`.
- Normaliza os dados para o intervalo [0, 1] com `caret::preProcess(method = "range")`.
- Retira a coluna categórica (`Area`) e roda `prcomp`.
- Gera o biplot com `ggfortify::autoplot`, com pontos coloridos por área, vetores (*loadings*) rotulados e linhas de referência em zero.
- **Saída:** `biplot_PCA-RJ.tif`

**Pacotes:** `ggfortify`, `caret`, `ggplot2`, `tidyverse`

#### `script_PCA_2.R`
Mesma lógica do anterior (grupos na coluna `LULC`), com **três versões** do biplot:
- `biplot_PCA.tif`: só os scores, sem vetores
- `biplotPCA.tif`: scores e vetores sem rótulos
- `plot_PCA.tif`: scores e vetores com **cores personalizadas** por uso da terra (PRS, MSF, SF, PST)

**Pacotes:** `caret`, `ggplot2`, `ggfortify`

#### `Correlacao.R`
Matriz de **correlação de Spearman** entre a produtividade, as predições e as covariáveis zonais (bandas do solo, declividade, TWI etc.).
- Seleciona e renomeia as colunas, remove NAs (`na.omit`) e padroniza os dados (`scale`).
- Plota a matriz triangular inferior, com agrupamento hierárquico (`hc.order = TRUE`) e coeficientes escritos nas células (`ggcorrplot`).
- **Saída:** `Correlacao.tif`

**Pacotes:** `ggcorrplot` (o script também carrega `corrplot` e `GGally`)

#### `script_matriz_correlacao.R`
Matriz de **correlação de Pearson** com `corrplot`, a partir de `RJ.csv`.
- Padroniza as variáveis, calcula `cor()` e plota a matriz triangular inferior com os coeficientes, ordenados pelo método AOE (ângulo dos autovetores).
- Usa uma paleta personalizada com intervalos de 0,25 entre −1 e 1.
- **Saída:** `Matrizcorrelacao-RJ.tif`

**Pacotes:** `corrplot`, `dplyr`

---

### 3. Avaliação de modelos e divisão de dados

#### `Regressao_R2_RPIQ_RMSE_Grafico.R`
Avalia predições (por exemplo, argila e areia preditas × medidas) com um **gráfico observado × predito**:
- Pontos, reta de regressão (vermelha) e reta 1:1 (preta).
- Métricas:
  - **R²**, escrito no gráfico com `ggpmisc::stat_poly_eq`
  - **RMSE** (raiz do erro quadrático médio), com `Metrics::rmse`
  - **RPIQ** (*Ratio of Performance to InterQuartile distance*) = (Q3 − Q1) / SEP
- **Saídas:** `Clay_lit.png`, `Sand_Lit.png` (300 dpi)

**Pacotes:** `ggplot2`, `ggpmisc`, `ggpubr`, `Metrics`

#### `Create_data_partition.R`
Divide um conjunto de dados em **calibração (70%)** e **validação (30%)** com `caret::createDataPartition`, uma amostragem estratificada pela variável-resposta (`Sand_gkg`). Os dois conjuntos são exportados em CSV.

**Pacotes:** `caret`. O objeto `Solo` já precisa estar carregado na sessão, por exemplo com `Exploratory_Analysis.R`.

---

### 4. Manipulação de dados

#### `Merge_Dataset.R`
Lê três tabelas (centroides e uma tabela de relação), padroniza os nomes das colunas e une tudo pela coluna **`BLOCO`** com `merge()`. Exporta `Ref_Teste.csv`.

#### `Merge_Dataset_2.R`
Faz um **left join** (`all.x = TRUE`) entre uma tabela de predições e uma tabela de estatísticas zonais, pela coluna **`KEY`**. Lê arquivos com acentos usando `fileEncoding = "latin1"`. Exporta `Teste2.csv`.

**Pacotes:** `dplyr`

#### `Merge_two_datasets_with_column_reference.R`
Une pontos filtrados às covariáveis amostradas em um buffer de 60 m, pela coluna **`FID`**. Exporta `Pts_Filtrado_Solo.csv`.

#### `Replace_Raster_NA.R`
Faz o pré-processamento de um raster de índice de vegetação (SAVI/NDVI):
1. Converte valores ≤ 0 em `NA`.
2. Transforma o raster em tabela (x, y, valor).
3. Substitui os `NA` pela **mediana** dos pixels válidos.
4. Reconstrói o raster em WGS84 (EPSG:4326) e exporta em GeoTIFF.

**Pacotes:** `raster`, `sp`, `rgdal`, `dplyr`, `tidyr`

---

### 5. Gráficos

#### `Bar-Graph-Breaks.R`
Gráfico de **barras empilhadas** do número de publicações científicas por ano e país (análise bibliométrica), a partir de `Country_Year.csv` (colunas `Country` e `Year`).
- Mantém os **10 países mais produtivos** e agrupa os demais em "Other".
- Preenche os anos sem publicações com zero (`tidyr::complete`).
- **Comprime visualmente** os períodos com poucas publicações (`excluded_years`), controlando a compressão com `compression_factor` (0 = totalmente comprimido).
- Cores e tamanhos de fonte ficam em variáveis no começo do script, fáceis de editar.
- **Saída:** `Teste.emf` (formato vetorial, editável no Word/PowerPoint)

**Pacotes:** `dplyr`, `ggplot2`, `tidyr`, `ggbreak`, `devEMF`

#### `Bar-Graph-Breaks2.R`
Alternativa ao anterior: em vez de comprimir o eixo, junta todas as publicações **até 1999 em uma única barra "histórica"** (rotulada, por exemplo, "1956-1999") e mostra os anos a partir de 2000 um a um.
- **Saída:** `Teste2.emf`
- ⚠️ Este script **começa na etapa 3** e não carrega pacotes nem dados. Rode antes as etapas 1 e 2 de `Bar-Graph-Breaks.R` (pacotes e leitura do CSV).

#### `Bar-Horizontal.R`
**Barras horizontais** com a média e o **erro padrão** (± SE) do Índice de Saúde do Solo (SHI) por uso da terra ou estágio de restauração. Calcula média, desvio padrão, n e erro padrão com `dplyr::summarise`.
- **Saída:** `SHI-RJ.tif`

**Pacotes:** `dplyr`, `ggplot2`

#### `Dual_Axis_Plot.R`
Gráfico com **dois eixos Y**: barras de produção de camarão (eixo esquerdo) e linha da área de manguezal (eixo direito). A linha é reescalonada para o eixo primário e o eixo secundário é criado com `sec_axis()`, que aplica a transformação inversa. Usa o tema `theme_economist`.
- **Saída:** `Mangrove-Shrimp.tif`
- Os limites usados no reescalonamento (220–240 e 35–155) estão fixos no código e precisam ser ajustados para cada conjunto de dados.

**Pacotes:** `ggplot2`, `ggthemes`, `scales`

#### `Grafico_Radar.R`
**Gráfico de radar** (*spider chart*) para comparar, por exemplo, a importância de variáveis entre modelos ou áreas (`Var_Imp_5.csv`).
- O começo do script é um tutorial com dados simulados, baseado no R Graph Gallery.
- O `fmsb` exige que as duas primeiras linhas da tabela sejam o **máximo** e o **mínimo** de cada eixo (`rbind(rep(100, n), rep(0, n), dados)`).
- **Saídas:** `Area_A.tif`, `Radar_Geophysic_Relief.tif`

**Pacotes:** `fmsb`, `RColorBrewer`

#### `Textural_Triangle.R`
Plota amostras de solo no **triângulo textural** pelo sistema **USDA** ou pelo **SiBCS** (Sistema Brasileiro de Classificação de Solos).
- Os dados precisam das colunas `CLAY`, `SILT` e `SAND` (em %).
- Permite **sobrepor dois conjuntos** no mesmo triângulo (por exemplo, textura predita × tradicional) com `TT.points`.
- **Saídas:** `Text_Triangle.tif`, `Area_B.tif`

**Pacotes:** `soiltexture`

#### `Variable_Importance_Graphic.R`
Gráfico de **importância de variáveis**, como as de um Random Forest: barras horizontais ordenadas da mais para a menos importante (`reorder`), coloridas por classe.
- **Entrada:** `Variables_Importance.csv` (colunas `Variable`, `Importance`, `Class`)
- **Saída:** `var_imp_.tif`

**Pacotes:** `ggplot2`, `dplyr`, `forcats`

#### `Var-Imp-Axis-Break.R`
Mesma ideia do anterior, mas com **quebra no eixo** (`scale_y_break(c(5000, 25000))`), útil quando um valor é muito maior que os outros. O exemplo conta classes de bioma por estado (`Biomas_Count.csv`).
- **Saída:** `var_imp_states.tif`

**Pacotes:** `ggplot2`, `dplyr`, `forcats`, `scales`, `ggbreak`

---

## Pacotes necessários

Para instalar todos os pacotes de uma vez:

```r
pacotes <- c(
  # Manipulação de dados
  "dplyr", "tidyr", "tidyverse", "forcats",
  # Gráficos
  "ggplot2", "ggthemes", "scales", "hrbrthemes", "ggbreak",
  "ggpubr", "ggpmisc", "ggfortify", "RColorBrewer", "devEMF",
  # Correlação
  "corrplot", "ggcorrplot", "GGally",
  # Estatística e modelagem
  "caret", "Metrics", "moments", "car",
  # Gráficos específicos
  "fmsb", "soiltexture",
  # Dados espaciais
  "raster", "sp"
)

instalar <- pacotes[!pacotes %in% rownames(installed.packages())]
if (length(instalar) > 0) install.packages(instalar)
```

> **Sobre o `rgdal`:** o pacote foi retirado do CRAN em 2023 e é usado apenas em `Replace_Raster_NA.R`. Nas versões atuais do R, apague a linha `library(rgdal)`: o `raster` e o `sp` funcionam sem ele. Outra opção é migrar para o pacote `terra`.

### Pacotes por script

| Script | Pacotes |
|---|---|
| `Bar-Graph-Breaks.R` / `Bar-Graph-Breaks2.R` | dplyr, ggplot2, tidyr, ggbreak, devEMF |
| `Bar-Horizontal.R` | dplyr, ggplot2 |
| `Boxplot.R`, `Boxplot-Multiplos.R`, `Boxplot-Multiplos-2.R` | ggplot2 |
| `Correlacao.R` | ggcorrplot (corrplot, GGally) |
| `Create_data_partition.R` | caret |
| `Dual_Axis_Plot.R` | ggplot2, ggthemes, scales |
| `Exploratory_Analysis.R` | ggplot2, car, moments, dplyr |
| `Grafico_Radar.R` | fmsb, RColorBrewer |
| `Histograma.R` | ggplot2, dplyr, hrbrthemes, raster |
| `Merge_Dataset.R`, `Merge_two_datasets_with_column_reference.R` | R base |
| `Merge_Dataset_2.R` | dplyr |
| `PCA-SHI.R` | R base |
| `Regressao_R2_RPIQ_RMSE_Grafico.R` | ggplot2, ggpmisc, ggpubr, Metrics |
| `Replace_Raster_NA.R` | raster, sp, dplyr, tidyr (rgdal) |
| `script_PCA.R` | ggfortify, caret, ggplot2, tidyverse |
| `script_PCA_2.R` | caret, ggplot2, ggfortify |
| `script_matriz_correlacao.R` | corrplot, dplyr |
| `Textural_Triangle.R` | soiltexture |
| `Var-Imp-Axis-Break.R` | ggplot2, dplyr, forcats, scales, ggbreak |
| `Variable_Importance_Graphic.R` | ggplot2, dplyr, forcats |

---

## Como executar

### Pré-requisitos
- **R** 4.x ou mais recente ([cran.r-project.org](https://cran.r-project.org/))
- **RStudio**, recomendado ([posit.co](https://posit.co/download/rstudio-desktop/))

### Passo a passo

1. **Instale os pacotes** com o bloco de código da seção anterior. Isso só precisa ser feito uma vez.

2. **Abra o script** no RStudio.

3. **Ajuste os diretórios.** Todos os scripts usam o marcador `DIRETORIO/SUBPASTA` no lugar do caminho real. Troque pelo caminho da sua pasta, **sempre com barras normais** (`/`):
   ```r
   setwd("C:/Users/SeuUsuario/Documents/MeuProjeto/Dados")
   ```
   Crie também a subpasta `Figuras/`, que muitos scripts usam para salvar as imagens.

4. **Ajuste o arquivo de entrada e os nomes das colunas**, como `read.csv("SeuArquivo.csv", ...)`, os índices de colunas (`bd[, c(4:12)]`) e os nomes usados em `aes(...)`.

5. **Execute linha a linha ou por blocos** (`Ctrl + Enter`), conferindo as saídas de `str()`, `colnames()` e `head()`. Os scripts foram escritos para uso interativo, então evite rodar tudo com `source()` sem revisar antes.

6. **Exportação das figuras.** Os gráficos são salvos entre `tiff(...)`/`emf(...)`/`ggsave(...)` e `dev.off()`. Se a imagem sair em branco, envolva o gráfico ggplot em `print(...)` entre a abertura do dispositivo e o `dev.off()`.

### Dica: as linhas `install.packages()`
Vários scripts têm `install.packages(...)` no meio do código. Depois da primeira instalação, **comente essas linhas** (`#`) para o pacote não ser reinstalado a cada execução.

---

## Formato dos dados de entrada

- Arquivos **CSV separados por ponto e vírgula** (`sep = ";"`), o padrão do Excel em português.
- Separador decimal: a maioria dos scripts usa `dec = "."`. Se o seu CSV usa vírgula decimal, troque para `dec = ","`.
- Arquivos com acentos podem precisar de `fileEncoding = "latin1"` ou `"UTF-8"`.
- Rasters em **GeoTIFF** (`.tif`).

| Script | Colunas esperadas (exemplo) |
|---|---|
| `Bar-Graph-Breaks*.R` | `Country`, `Year` |
| `Boxplot-Multiplos*.R` | `Area` ou `LULC`, `Attribute`, `Value` (formato longo) |
| `Bar-Horizontal.R` | `Land.Use`, `SHI` |
| `Dual_Axis_Plot.R` | `Year`, `Production`, `Mangrove` |
| `Textural_Triangle.R` | `CLAY`, `SILT`, `SAND` (%) |
| `Variable_Importance_Graphic.R` | `Variable`, `Importance`, `Class` |
| `Var-Imp-Axis-Break.R` | `State`, `Count`, `Class` |
| `Grafico_Radar.R` | 1ª coluna = nomes das linhas; demais = eixos do radar |
| `PCA-SHI.R` | colunas numéricas, por exemplo `Zn`, `Cu`, `Pb`, `N`, `pH`, `eH`, `C`, `Sand`, `SC` |

---

## Pontos de atenção

Alguns scripts são rascunhos ou modelos e dependem de objetos criados em outra sessão. Confira antes de executar:

| Script | Observação |
|---|---|
| `Bar-Graph-Breaks2.R` | Não carrega pacotes nem dados. Rode antes as etapas 1–2 de `Bar-Graph-Breaks.R`. |
| `Boxplot.R` | `mynamestheme` é definido **depois** do gráfico. Mova o bloco `mynamestheme <- theme(...)` para antes do `ggplot`. |
| `Boxplot-Multiplos-2.R` | Falta `library(ggplot2)` no início. |
| `Create_data_partition.R` | Precisa de `library(caret)` e do objeto `Solo`. Os objetos exportados (`PTS_Cal`, `PTS_Val`) e `PI.val` não existem: use `Solo_cal` e `Solo_val`. |
| `Exploratory_Analysis.R` | Usa `Solo_PCA`, que não é criado no script. `count()` precisa do `dplyr`, e o `lm(..., data = mtcars)` deve usar os seus dados. |
| `Histograma.R` | Usa `bd_cor`, que não é criado no script. Substitua pelo seu data frame. |
| `Regressao_R2_RPIQ_RMSE_Grafico.R` | Usa `dados2`, que não é criado no script. O RPIQ do rótulo está escrito à mão (`"0.84"`, `"1.15"`), e o IQ deveria ser `quantile(x)[4] - quantile(x)[2]` (Q3 − Q1 dos valores observados). |
| `Merge_two_datasets_with_column_reference.R` | `colnames(Pts_Completo_2)` aparece antes de o objeto ser criado. |
| `script_PCA_2.R` | `colnames(bd)` se refere a um objeto inexistente (o correto é `bd2`). |
| `script_matriz_correlacao.R` | Precisa de `library(dplyr)` para o `%>%`, e `corrplot(dados, ...)` deve receber a matriz de correlação, não o data frame. |
| `Var-Imp-Axis-Break.R` | Falta `library(ggbreak)` para `scale_y_break()`. |
| `Replace_Raster_NA.R` | `rgdal` não está mais no CRAN (veja a seção de pacotes). |
| Vários | Alguns arquivos foram salvos em Latin-1 e os acentos aparecem quebrados. No RStudio, use *File → Reopen with Encoding… → ISO-8859-1* para corrigir. |
