library(tm)
library(wordcloud)
library(SnowballC)
library(RColorBrewer)

tweets <- readLines("Desktop/TIO/Proyecto Final/nube_palabras/source/tweets.txt",encoding="UTF-8")
tweets <- iconv(tweets,to="ASCII//TRANSLIT")

corpus <- Corpus(VectorSource(tweets))

#Limpiamos el ruido
d <- tm_map(corpus, content_transformer(tolower))
d <- tm_map(d, stripWhitespace)
d <- tm_map(d, removePunctuation)
d <- tm_map(d,removeNumbers)

#Palabras vacías de la biblioteca
d <- tm_map(d, removeWords,stopwords("english"))
d <- tm_map(d, removeWords,stopwords("spanish"))

#Palabas vacías personalizadas y lo convierte a ASCII
sw <- readLines("Desktop/TIO/Proyecto Final/nube_palabras/stopwords/stopwords.es",encoding = "UTF=8")
sw <- iconv(sw, to="ASCII//TRANSLIT")
d <- tm_map(d,removeWords,sw)

sw <- readLines("Desktop/TIO/Proyecto Final/nube_palabras/stopwords/stop-words_english_2_en.txt",encoding = "UTF=8")
sw <- iconv(sw, to="ASCII//TRANSLIT")
d <- tm_map(d,removeWords,sw)

sw <- readLines("Desktop/TIO/Proyecto Final/nube_palabras/stopwords/stop-words_english_3_en.txt",encoding = "UTF=8")
sw <- iconv(sw, to="ASCII//TRANSLIT")
d <- tm_map(d,removeWords,sw)

sw <- readLines("Desktop/TIO/Proyecto Final/nube_palabras/stopwords/stop-words_english_4_google_en.txt",encoding = "UTF=8")
sw <- iconv(sw, to="ASCII//TRANSLIT")
d <- tm_map(d,removeWords,sw)

sw <- readLines("Desktop/TIO/Proyecto Final/nube_palabras/stopwords/stop-words_english_5_en.txt",encoding = "UTF=8")
sw <- iconv(sw, to="ASCII//TRANSLIT")
d <- tm_map(d,removeWords,sw)

sw <- readLines("Desktop/TIO/Proyecto Final/nube_palabras/stopwords/stop-words_english_6_en.txt",encoding = "UTF=8")
sw <- iconv(sw, to="ASCII//TRANSLIT")
d <- tm_map(d,removeWords,sw)

sw <- readLines("Desktop/TIO/Proyecto Final/nube_palabras/stopwords/customsw.txt",encoding = "UTF=8")
sw <- iconv(sw, to="ASCII//TRANSLIT")
d <- tm_map(d,removeWords,sw)

#Creación de matriz de términos
tdm <- TermDocumentMatrix(d)

#Convierte a matriz
m = as.matrix(tdm)

#conteo de palabras en orden decreciente
wf <- sort(rowSums(m),decreasing = TRUE)

#crea un data.frame con las palabras y sus frecuencias
dm <- data.frame(word=names(wf),freq=wf)

#Generación de la nube de etiquetas
png("Desktop/TIO/Proyecto Final/nube_palabras/nubes/nubefinal.jpeg", width=1280, height=800)
wordcloud(words = dm$word,freq = dm$freq,min.freq=20,random.order=FALSE,rot.per=0.35,colors=brewer.pal(8,"Dark2"))
dev.off()

