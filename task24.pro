encoding(utf8).

'мужчина'('Адам').
'мужчина'('Каин').
'мужчина'('Авель').
'мужчина'('Майкл').
'мужчина'('Моисей').
'мужчина'('Альберт').
'мужчина'('Эрнест').
'мужчина'('Гектор').
'мужчина'('Ганнибал').
'мужчина'('Александр').
'мужчина'('Филипп').

'женщина'('Ева').
'женщина'('Мадонна').
'женщина'('Мария').
'женщина'('Алиса').
'женщина'('Мэри').
'женщина'('Диана').
'женщина'('Сара').
'женщина'('Барбара').
'женщина'('Роза').
'женщина'('Алла').
'женщина'('Кристина').
'женщина'('Марианна').

'родитель'('Адам', 'Каин').
'родитель'('Адам', 'Авель').
'родитель'('Адам', 'Сара').
'родитель'('Моисей', 'Мэри').
'родитель'('Моисей', 'Майкл').
'родитель'('Каин', 'Алиса').
'родитель'('Каин', 'Диана').
'родитель'('Каин', 'Мадонна').
'родитель'('Майкл', 'Барбара').
'родитель'('Майкл', 'Гектор').
'родитель'('Майкл', 'Роза').
'родитель'('Майкл', 'Филипп').
'родитель'('Филипп', 'Кристина').
'родитель'('Ганнибал', 'Александр').
'родитель'('Ганнибал', 'Эрнест').
'родитель'('Александр', 'Альберт').
'родитель'('Альберт', 'Марианна').
'родитель'('Ева', 'Каин').
'родитель'('Ева', 'Авель').
'родитель'('Ева', 'Сара').
'родитель'('Сара', 'Мэри').
'родитель'('Сара', 'Майкл').
'родитель'('Мария', 'Алиса').
'родитель'('Мария', 'Гектор').
'родитель'('Мария', 'Диана').
'родитель'('Мария', 'Мадонна').
'родитель'('Мадонна', 'Барбара').
'родитель'('Мадонна', 'Роза').
'родитель'('Мадонна', 'Филипп').
'родитель'('Алла', 'Кристина').
'родитель'('Диана', 'Александр').
'родитель'('Барбара', 'Эрнест').
'родитель'('Барбара', 'Альберт').
'родитель'('Кристина', 'Марианна').



'братсестра'(X, Y):- 'родитель'(Z, X), 'родитель'(Z, Y)
                            , X\=Y.

'племянник'(X, Y):- 'родитель'(Z, X), 'братсестра'(Z, Y).

'кузина'(X, Y):- 'родитель'(Z, X), 'родитель'(C, Y), 'братсестра'(Z,C)
                      ,'женщина'(X), 'женщина'(Y).

					  

'потомокАдама'(X) :- 'родитель'('Адам', X); 'родитель'(Y, X), 'мужчина'(Y)
                             ,'потомокАдама'(Y).
'предокАльберта'(X):-'родитель'(X, 'Альберт'), 'женщина'(X); 
								'родитель'(X, Y)
                              ,'женщина'(Y), 'предокАльберта'(Y).
					  
					  
subtask1 :- 'потомокАдама'(X), write(X).
subtask2 :- 'предокАльберта'(X), write(X).
subtask3 :- 'племянник'(X, Y), write(X), write(' есть племянник '), write(Y).
subtask4 :- 'кузина'(X, Y), write(X), write(' есть дв. сестра  '), write(Y).

