# exercicio-amostragem
# Exercício Amostragem

Projeto em R com dependências gerenciadas pelo [renv](https://rstudio.github.io/renv/).

## Como clonar e rodar

### 1. Clonar o repositório
```bash
git clone https://github.com/fulede21/exercicio-amostragem.git
cd exercicio-amostragem

# Abra o arquivo exercicio-amostragem.Rproj no Rstudio
setwd("caminho/para/exercicio-amostragem")

# Instale as dependencias
install.packages("renv")

# Restaure as dependencias
renv::restore()
