# Descrição de dados -----------------------------------------------------------------------------------------------------------------------

### Descrever valores de média, mediana, desvio padrão, valores máximos e mínimos.

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

dados <- datasets::airquality
dados

# Sobre os dados ---------------------------------------------------------------------------------------------------------------------------

### Medidas diárias da qualidade do ar em Nova York de maio a setembro de 1973.

# Estatística descritiva dos dados ---------------------------------------------------------------------------------------------------------

### Descrição dos dados de temperatura e vento 

mean(dados$Temp) # média
sd(dados$Temp) # desvio-padrão
median(dados$Temp) # mediana
max(dados$Temp) # temperatura máxima
min(dados$Temp) # temperatura mínima

mean(dados$Wind) # média
sd(dados$Wind) # desvio-padrão
median(dados$Wind) # mediana
max(dados$Wind) # vento máximo
min(dados$Wind) # vento mínimo

library(dplyr) # Pacote usado para análises descritivas

### Média e desvio padrão da temperatura e vento para cada mês

d <- dados %>% 
  select(Month, Temp, Wind) %>%
  group_by(Month) %>%
  summarise(media_temp = mean(Temp),
            media_vento = mean(Wind),
            desvio_temp = sd(Temp),
            desvio_vento = sd(Wind))
d

# Gráficos ---------------------------------------------------------------------------------------------------------------------------------

library(ggplot2) # Pacote para produzir os gráficos
#install.packages("hrbrthemes")
library(hrbrthemes)

## Temperatura

ggplot(d, aes(x = Month, y = media_temp, fill = Month)) +
  geom_col() +
    geom_text(aes(x = Month,
                label = round(media_temp)), 
                size = 4.2,vjust = 0.03) +
  labs(x = "Meses", y = "Temperatura média") +
  theme(legend.position = "none")

## Vento

ggplot(d, aes(x = Month, y = media_vento, fill = Month)) +
  geom_col() +
    geom_text(aes(x = Month,
                label = round(media_vento)), 
                size = 4.2,vjust = 0.03) +
  labs(x = "Meses", y = "Ventania média") +
  theme(legend.position = "none")
