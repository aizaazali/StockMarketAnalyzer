# Graphical representation of analysis output and comparing it with stock data

# Tesla 
tesla <- read.csv(file.choose(),header =T) #Read the sentiments scores
tesla <- tesla$X0.12608608445817598

#Normalize the data. Because out sentiment analysis scores and stock prices are
# on different scales, we normalize them.

normalized_tesla = (tesla-min(tesla))/(max(tesla)-min(tesla))
tesla_ts <- ts(normalized_tesla)

# Read Tesla stock data
tesla_off <- read.csv(file.choose(),header =T)
tesla_off <- tesla_off$Open[1:57]

#normalize tesla stock data

normalized_tesla_off = (tesla_off-min(tesla_off))/(max(tesla_off)-min(tesla_off))
tesla_off_ts <- ts(normalized_tesla_off)

#plot tesla data.
#blue represents our analysis and red represents tesla stock price
ts.plot(tesla_ts,tesla_off_ts, gpars = list(col = c("blue","red")))

#ibm
ibm <- read.csv(file.choose(),header =T) #Read the sentiments scores
ibm <- ibm$X.0.37576034004164763

#Normalize the data. Because out sentiment analysis scores and stock prices are
# on different scales, we normalize them.

normalized_ibm = (ibm-min(ibm))/(max(ibm)-min(ibm))
ibm_ts <- ts(normalized_ibm)

#read ibm stock data
ibm_off <- read.csv(file.choose(),header =T)
ibm_off <- ibm_off$Open[1:57]

#normalize ibm stock data
normalized_ibm_off = (ibm_off-min(ibm_off))/(max(ibm_off)-min(ibm_off))
ibm_off_ts <- ts(normalized_ibm_off)

#plot ibm data
#blue represents our analysis and red represents ibm stock price
ts.plot(ibm_ts,ibm_off_ts, gpars = list(col = c("blue","red")))

#read amazon sentiment analysis data
amazon <- read.csv(file.choose(),header =T)
amazon <- amazon$X0.22551668338122222

#normalize the data
normalized_amazon = (amazon-min(amazon))/(max(amazon)-min(amazon))
amazon_ts <- ts(normalized_amazon)

#read amazon stock data
amazon_off <- read.csv(file.choose(),header =T)
amazon_off <- amazon_off$Open[1:57]

#normalize amazon stock data
normalized_amazon_off = (amazon_off-min(amazon_off))/(max(amazon_off)-min(amazon_off))
amazon_off_ts <- ts(normalized_amazon_off)

#plot amazon data
#blue represents our analysis and red represents amazon stock price
ts.plot(amazon_ts,amazon_off_ts ,gpars = list(col = c("blue","red")))




