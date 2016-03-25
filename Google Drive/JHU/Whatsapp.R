# Script to Analyze Whatsapp Messages
## You need to export the chat from Whatsapp, and clean the data in Excel, then save as .csv

rm(list = ls())
library(ggplot2)

# Import 
chat <- read.csv("~/Desktop/chat.csv", header = TRUE)
head(chat)
table(chat$Autor)

# Remove Comma From Date String
chat$Fecha <- sub(',', '', chat$Fecha)

# Format as Date Time

chat$Fecha <- as.Date(chat$Fecha, "%m/%d/%y")
chat$Fecha_working <- paste(chat$Fecha, chat$Hora, sep=" ")
chat$Fecha_working <- strptime(chat$Fecha_working, "%Y-%m-%d %H:%M:%S")

chat$Mes <- months(chat$Fecha_working, abbreviate = TRUE)
chat$Dia <- weekdays(chat$Fecha_working, abbreviate = TRUE)
chat$Hora <- format(chat$Fecha_working, "%H")
chat$Fecha_working <- as.Date(as.character(chat$X), format = "%Y-%m-%d")

ggplot(chat, aes( x = Autor, fill = Autor)) + geom_histogram(binwidth = 30) + ggtitle("Cantidad de Mensajes por Autor") + labs(y = "Mensajes Enviados")
ggplot(chat, aes( x = Fecha, fill = Autor)) + geom_histogram(binwidth = 30) + ggtitle("Cantidad de Mensajes por Mes") + labs(y = "Mensajes Enviados")
ggplot(chat, aes( x = Hora, fill = Autor)) + geom_histogram(binwidth = 30) + ggtitle("Cantidad de Mensajes por Hora del Día") + labs(y = "Mensajes Enviados")
