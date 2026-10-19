# Importar as Biblioteca para manipulacao de dados
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)

# Filtrar todos os avisos
options(warn = -1)

# Carregar dados
getwd()
list.files("../base_dados/dados_limpos")
doencas <- read.csv("../base_dados/doencas.csv")

# Estrutura de dados
print('Base: Doenças')
glimpse(doencas)

# Estatistica basica
print('Base: Doenças')
summary(doencas)

# Verificar a quantidade de valores ausentes por coluna
print(colSums(is.na(doencas)))

# Transformar a coluna data em datetime
doencas$data_notificacao <- as.Date(doencas$data_notificacao)

# Extrair e criar colunas com: data, ano, e dia de semana
doencas <- doencas %>%
    mutate(
        mes = month(data_notificacao),
        ano = year(data_notificacao),
        dia = wday(data_notificacao, label= TRUE)
    )

# Remover espacos extras
doencas$provincia <- trimws(doencas$provincia)

# Verificar repeticoes
print(unique(doencas$provincia))

# Padronizar valores da coluna
doencas <- doencas %>%
    mutate(provincia = recode(
    provincia,
    'Zambézia' = 'Zambezia',
    "Maputo Província" = 'Maputo Provincia'
))

# verificar dados
print(unique(doencas$doenca))

# Remover espacos extras e capitalizar iniciais
doencas$doenca <- trimws(doencas$doenca)
doencas$doenca <- tolower(doencas$doenca)

# Padronizar valores da coluna
doencas <- doencas %>%
    mutate(doenca = recode(
    doenca,
    "malaria" = "malária"
))

print(unique(doencas$sexo))

# Padronizar valores da coluna
doencas <- doencas %>%
    mutate(sexo = recode(
    sexo,
    "f" = "Feminino",
    "F" = "Feminino",
    "feminino" = "Feminino",
    "m" = "Masculino",
    "M" = "Masculino",
    "masculino" = "Masculino"
))
doencas$sexo[doencas$sexo == ""] <- "Desconhecido"


print(unique(doencas$idade))
# Corigir valores mal escritos
doencas$idade <- replace(doencas$idade, doencas$idade == 200, 20)
doencas$idade <- replace(doencas$idade, doencas$idade == -5, 5)
doencas$idade <- replace(doencas$idade, doencas$idade == 150, 15)
doencas$idade <- replace(doencas$idade, doencas$idade == 130, 13)
doencas$idade <- replace(doencas$idade, doencas$idade == -1, 1)

# prencher valores ausentes com media de idades
doencas$idade[is.na(doencas$idade)] <- mean(doencas$idade, na.rm = TRUE)

print(unique(doencas$dias_internamento))
class(doencas$dias_internamento)

# Substituir NA com zero
doencas$dias_internamento[is.na(doencas$dias_internamento)] <- 0

print(unique(doencas$desfecho))

### Salvar o DataFrame
write.csv(doencas,'../base_dados/dados_limpos/dados_doencas.csv', row.names = FALSE)

print('Base de dados tratada e salva em ../base_dados/dados_limpos/')

# Carregar a base 
populacao <- read.csv("../base_dados/populacao.csv")

populacao_updat = data.frame(
    
    'provincia' = populacao$provincia,
    
    'total' = c(1139476, 2662034, 1500120,1616068, 2827922,
     2429085, 3368004, 6313864,6984269, 2349195, 2900922),
   
    'homens' = c(555091, 1288812, 685836, 756271, 1381254, 
    1177399, 1662899, 3050249, 3406061, 1145590, 1414627),
    
    'mulheres' = c(584385, 1373222, 814284, 859797,1446668,
     1251686, 1705105, 3263615, 3578208, 1203605, 1485802)
)

# Inspecionar
print(unique(populacao_updat))

write.csv(populacao_updat,'../base_dados/dados_limpos/populacao_updat.csv', row.names = FALSE)
print('Base de dados tratada e salva em ../base_dados/dados_limpos/')