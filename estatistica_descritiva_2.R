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

# Etapas da produção dos gráficos ----------------------------------------------------------------------------------------------------------

# 1. Definir variáveis e tipo de gráfico;
# 2. Definir títulos dos eixos;
# 3. Acrescentar um tema ao gráfico, reduzir largura das barras e retirar a legenda
# 4. Transformar mês em variável fatorial e mudar nome dos eixos
# 5. Nomear os gráficos e uni-los em uma janela.

# Gráficos ---------------------------------------------------------------------------------------------------------------------------------

library(ggplot2) # Pacote para produzir os gráficos
#install.packages("hrbrthemes")
library(hrbrthemes) # Pacote para mudar o tema do gráfico (cor preta)

d$Month <- as.factor(d$Month)

## Temperatura

a <- ggplot(d, aes(x = Month, y = media_temp, fill = Month)) +
  geom_col(width = 0.6) +
  geom_text(aes(x = Month,
                label = round(media_temp)), 
                size = 4, vjust = 0.03) +
  scale_x_discrete(breaks = c(5, 6, 7, 8, 9),
                   labels = c("Maio", "Junho", "Julho",
                              "Agosto", "Setembro")) +
  labs(x = "Meses", y = "Temperatura média") +
  theme_ipsum_rc(base_size = 10) +
  theme(legend.position = "none")
a

## Vento

b <- ggplot(d, aes(x = Month, y = media_vento, fill = Month)) +
  geom_col(width = 0.6) +
  geom_text(aes(x = Month,
                label = round(media_vento)), 
                size = 4, vjust = 0.03) +
  scale_x_discrete(breaks = c(5, 6, 7, 8, 9),
                   labels = c("Maio", "Junho", "Julho",
                              "Agosto", "Setembro")) +
  labs(x = "Meses", y = "Ventania média") +
  theme_ipsum_rc(base_size = 10) +
  theme(legend.position = "none")
b

library(cowplot) # Pacote usado para juntar gráficos

plot_grid(a, b)
