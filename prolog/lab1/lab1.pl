% parents
parent(vitaliy, amir).
parent(leysan, amir).
parent(valeriy, vitaliy).
parent(lusy, vitaliy).
parent(minimulla, leysan).
parent(sabira, leysan).
parent(alexandre, valeriy).
parent(gilfan, minimulla).
parent(sasha, alina).
parent(sasha, elvina).
parent(liliana, alina).
parent(liliana, elvina).
parent(minimulla, liliana).
parent(sabira, liliana).

% work: "Работа"
work(vitaliy, kredo).
work(leysan, hospital).
work(valeriy, electric).
work(lusy, teacher).
work(minimulla, deputy).
work(sabira, teacher).
work(alexandre, writer).
work(golfan, military).
work(liliana, none).
work(sasha, lukoil).

% sex: "Пол"
male(amir).
male(vitaliy).
male(valeriy).
male(minimulla).
male(alexandre).
male(sasha).
male(gilfan).
female(leysan).
female(lusy).
female(sabira).
female(alina).
female(elvina).
female(liliana).

% year of birthday: "Дни рождений"
year(amir, 2003).
year(alina, 2000).
year(elvina, 2009).
year(leysan, 1977).
year(vitaliy, 1977).

% rools: "Правила"
mother(X,Y) :- parent(X,Y),female(X).
father(X,Y) :- parent(X,Y),male(X).
children(X,Y) :- parent(Y,X).
grandmother(X,Y) :- mother(X,Z),parent(Z,Y).
grandfather(X,Y) :- male(X,Z),parent(z,y).

% husband && married: "Мужья и жены"
married(X,Y) :- parent(X,Z), parent(Y,Z), X \= Y.
husband(X,Y) :- male(X), married(X,Y).

% father-in-law && mother-in-law: "Тещи и тести"
fatherinlaw(X,Y) :- married(Z,Y), parent(X,Z), male(X).
motherinlaw(X,Y) :- married(Z,Y), parent(X,Z), female(X).

% son && daughter: "Дочери и сыновья"
son(X,Y) :- children(X,Y), male(X).
daughter(X,Y) :- children(X,Y), female(X).

% goal1: "Является ли Амир сыном Виталия?"
goal1 :- parent(vitaliy, amir),male(amir).
% "Можно так же использовать son(X,Y)"

% goal2: "Является ли Алина дочерью Саши?"
goal2 :- parent(sasha, alina),female(alina).
% "Можно так же использовать daughter(X,Y)"

% goal3: "Является ли Эльвина дочерью Саши?"
goal3 :- parent(sasha, elvina),female(elvina).
% "Можно так же использовать daughter(X,Y)"

% goal4: "Является ли Алина внучкой Сабиры?"
goal4 :- parent(liliana, alina),parent(sabira, liliana),female(alina).

% goal5: "Является ли Амир двоюродным братом Алины?"
goal5 :- parent(leysan, amir),parent(sabira, leysan),parent(sabira, liliana),parent(liliana, alina),female(alina),male(amir).

%goal6 "Вывести матерей и их детей"
goal6(X) :- mother(X, Y), writef("%t is mother of %t\n", [X, Y]).

%goal7 "Вывести матерей и их детей"
goal7(X) :- father(X, Y), writef("%t is father of %t\n", [X, Y]).

%goal8 "Является ли Алина сестрой Эльвины"
goal8(X) :- (parent(sasha, alina),parent(sasha, elvina);parent(liliana, alina),parent(liliana, elvina);(parent(sasha, alina),parent(sasha, elvina),parent(liliana, alina),parent(liliana, elvina),married(sasha, liliana))),female(alina),female(elvina), writef("%t is sister of %d\n", [alina,elvina]).

% goal9: "Моложе ли Амир чем Алина?"
goal9 :- year(amir, YearAmir), year(alina, YearAlina),
         YearAmir > YearAlina, write('Amir is younger than Alina').
goal9 :- year(amir, YearAmir), year(alina, YearAlina),
         YearAmir < YearAlina, write('Amir is older than Alina').
goal9 :- year(amir, YearAmir), year(alina, YearAlina),
         YearAmir =:= YearAlina, write('Amir and Alina are of the same age').

% goal10: "Моложе ли Эльвина чем Алина?"
goal10 :- year(elvina, YearElvina), year(alina, YearAlina),
YearAlina < YearElvina, write('Elvina is younger than Alina').
goal10 :- year(elvina, YearElvina), year(alina, YearAlina),
YearAlina > YearElvina, write('Elvina is older than Alina').
goal10 :- year(elvina, YearElvina), year(alina, YearAlina),
YearElvina =:= YearAlina, write('Elvina and Alina are of the same age').

% goal11: "Может ли Лейсан быть мамой Алины по возрасту?"
goal11 :- year(leysan, YearLeysan), year(alina, YearAlina),
Diff is YearAlina - YearLeysan,
Diff >= 18,
write('Yes, Leysan can be mother of Alina').

% goal12: "Является ли Лейсан дочерью учительницы?"
goal12 :-
    work(Teacher, teacher),
    mother(Teacher, leysan),
    writef('Yes, Leysan is the daughter of someone who works as a teacher. And teacher && mom is %t\n', [Teacher]).

% goal13: "Есть ли у нефтяника дочь?"
goal13 :- (parent(Father, Daughter);
    daughter(Daughter, Father)),
    female(Daughter),
    male(Father),
    work(Father, lukoil),
    writef('%w is father of %w and %w is oilman', [Father, Daughter, Father]).

