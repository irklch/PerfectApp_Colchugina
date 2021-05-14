//
//  NewsFeedList.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import Foundation
struct News {
    
    var groupName: String
    var groupIcon: String
    var newsImage: String
    var newsTitle: String
    var newsText: String
    var likeCount: Int
    var commentCount: Int
    var shareCount: Int
    var viewCount: Int
    
    static var list = [
        News.init(
            groupName: "Код Дурова",
            groupIcon: "Код Дурова",
            newsImage: "Код Дурова новость",
            newsTitle: "​ИИ научили переводить код с одного языка программирования на другой",
            newsText: """
Назвали всё это дело IBM CodeNet.
Разработчики заявили, что их проект может быть полезен при переводе устаревшего кода с условного COBOL и FORTRAN на свежие Java, C++ и Python.
""",
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100)),
        News.init(
            groupName: "Эксплойт",
            groupIcon: "Эксплойт",
            newsImage: "Эксплойт новость",
            newsTitle: "​Вышла первая бета Python 3.10",
            newsText: """
                            И уже сейчас можно увидеть, в каком направлении движется язык. Тут и попытка реализовать свой switch/case, и улучшение отчётов об ошибках.
                            """,
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100)),
        News.init(
            groupName: "СТАС БОМБИТ",
            groupIcon: "СТАС БОМБИТ",
            newsImage: "СТАС БОМБИТ новость",
            newsTitle: "​Google заменила Bash-скрипты на более удобные JavaScript-аналоги и поделилась ими с разработчиками",
            newsText: """
                            Для этого компания написала отдельный пакет-надстройку, названный ZX
                            """,
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100)),
        News.init(
            groupName: "Терабит- it технологии",
            groupIcon: "Терабит- it технологии",
            newsImage: "Терабит- it технологии новость",
            newsTitle: "​​Вышло VSCode-расширение для работы с кодом в разных файлах без необходимости переключаться между ними",
            newsText: """
                            Например, пользователь кликает на вызов функции, а расширение открывает её в том же окне, в котором разработчик уже находится в этот момент.
                            """,
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100)),
        News.init(
            groupName: "Книги для программистов",
            groupIcon: "Книги для программистов",
            newsImage: "Книги для программистов новость",
            newsTitle: "​Совсем скоро пройдёт онлайн-хакатон с призовым фондом до 4,5 млн рублей и возможностью посетить офлайн-хабы",
            newsText: """
                            Всего будет 8 кейсов от различных компаний-партнёров, а офлайн-коворкинги для участия будут доступны в 10 городах. При этом ничто не мешает заниматься решением задач и сидя дома, через интернет.
                            
                            Интересные задачи для себя найдут как веб-разработчики и любители анализа данных, так и разработчики искусственного интеллекта. Сам хакатон продлится 48 часов, с 21 по 23 мая.
                            """,
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100)),
        News.init(
            groupName: "Утечки информации",
            groupIcon: "Утечки информации",
            newsImage: "Утечки информации новость",
            newsTitle: "​Код реверс-инжиниринга GTA III восстановят, несмотря на блокировку правообладателя",
            newsText: """
                            И это даже не какое-то особое проявление любви к проекту от GitHub.
                            
                            Просто правила DMCA предписывают ей поступить именно таким образом в сложившейся ситуации (спойлер: Take-Two забыла вовремя обжаловать оспаривание блокировки).
                            """,
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100)),
        News.init(
            groupName: "IT и СОРМ",
            groupIcon: "IT и СОРМ",
            newsImage: "IT и СОРМ новость",
            newsTitle: "​Нейросеть «научила» киноактёров правдоподобно говорить на иностранном языке",
            newsText: """
                            Выглядит немного жутко, но очень впечатляюще.
                            
                            Технология TrueSync, которая и ответственная за правдоподобный дубляж, основывается на deepfake-нейросети. С её помощью на лица актёров накладывают «маску», сохраняющую актёрскую игру, но говорящую фразы на иностранном языке.
                            """,
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100)),
        News.init(
            groupName: "Библиотека программиста",
            groupIcon: "Библиотека программиста",
            newsImage: "Библиотека программиста новость",
            newsTitle: "​Вышло первое крупное обновление Kotlin в 2021 году",
            newsText: """
                            Версия 1.5 принесла много интересных нововведений, в том числе поддержку особенностей Java 15 и использование JVM IR компилятора по дефолту.
                            
                            Но вообще, разумеется, нового в апдейте гораздо больше. При этом что интересно, разработчики языка даже пообещали «разжевать» непонятные моменты на специальной онлайн-встрече.
                            """,
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100)),
        News.init(
            groupName: "NOP--Nuances of programming",
            groupIcon: "NOP--Nuances of programming",
            newsImage: "NOP--Nuances of programming новость",
            newsTitle: "​Nintendo анонсировала конструктор игр, обучающий азам программирования",
            newsText: """
                            Функции заменены на «нодонов», а сложные конструкции на игровую механику.
                            
                            Но по итогу с помощью Game Builder Garage можно будет создавать если не нового Ведьмака, то как минимум простенькие аркадки. Бонусом идёт получение базовых знаний по программированию.
                            
                            """,
            likeCount: Int.random(in: 0...100),
            commentCount: Int.random(in: 0...100),
            shareCount: Int.random(in: 0...100),
            viewCount: Int.random(in: 0...100))
    ]
    
    
}
