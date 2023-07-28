# quran_audio

Quran App is a useful application using Flutter framework , include the QUean Surah meta data , pages and also audio using Alafasi sound , in another hand that include a search functionality that allow user to search about any word or phraser in the quran and also after the results appear can click to any result and the app show for the user the page that include the aya that user search for it ,  ih hope good reading and quite sound and many feature in the app can use it ...

## for developers :
Model folder include : 
SearchModel: is a class include the data that user care about it when search for any word or .. , so its make the results from search more flexible to use as an object from this model.

Surah : is a model include all quran surah (meta data) data ,so when get the results from search about api we put it as a list of objects from Surah class.

Network.dart : file dealing with http and network to get the results from apis [notice : in this app i use 5 apis (for meta data , for Surah images , for search ,for audio and for query about each surah strat from any page and to any page )]

linked.dart : file responsible for Linked methods in network file and models we need , so the UI can use the methods inside it not the methods in network or direct uses the data from model.


## Getting Started
