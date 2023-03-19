% 15 вариант

% Определяем функцию arcsinx
% Принимает аргументы: x - значение переменной, n - количество слагаемых в ряду, Result - результат вычислений, Error - абсолютная погрешность
arcsinx(X, N, Result, Error) :-
    abs(X) >= 1,
    format("Error: |x| >= 1"),
    !.

arcsinx(X, N, Result, Error) :-
    arcsin(X, N, Approx), % Вычисляем приближенное значение с помощью ряда Тейлора
    Result is Approx, % Присваиваем приближенное значение результату
    Exact is asin(X), % Вычисляем точное значение с помощью встроенной функции arcsin
    Error is abs(Exact - Result), % Вычисляем абсолютную погрешность
    format("Approximation: ~6f~nExact value: ~6f~nAbsolute error: ~6f", [Result, Exact, Error]). % Выводим результаты

% Определяем вспомогательную функцию для вычисления ряда
% Принимает аргументы: x - значение переменной, n - количество слагаемых в ряду, Current - текущая сумма, Sum - итоговая сумма
arcsin_series(X, N, Current, Sum) :-
    N =:= 0, % Если n = 0, присваиваем текущей сумме значение итоговой суммы и прерываем вычисления
    Sum is Current,
    !.

arcsin_series(X, N, Current, Sum) :-
    N > 0, % Если n > 0, продолжаем вычисления
    Next is N - 1,
    coeff(X, N, Coeff), % Вычисляем коэффициент для текущего слагаемого
    Term is (Coeff * X^(2*N + 1)), % Вычисляем текущее слагаемое
    NewCurrent is Current + Term, % Добавляем текущее слагаемое к текущей сумме
    arcsin_series(X, Next, NewCurrent, Sum). % Рекурсивно вызываем функцию для следующего слагаемого

% Определяем вспомогательную функцию для вычисления коэффициента
% Принимает аргументы: x - значение переменной, n - порядковый номер коэффициента, Coeff - значение коэффициента
coeff(X, N, Coeff) :-
    N =:= 0, % Если n = 0, присваиваем коэффициенту значение 1 и прерываем вычисления
    Coeff is 1,
    !.

coeff(X, N, Coeff) :-
    N > 0,
    Prev is N - 1,
    coeff(X, Prev, PrevCoeff),
    Coeff is PrevCoeff * (2*N - 1) * X^2 / (2*N),
    !.

% Определяем функцию, которая вызывает вспомогательные функции для вычисления ряда
arcsin(X, N, Approx) :-
    arcsin_series(X, N, 0, Approx).

% Пример 1: arcsinx(1, 5, Result, Error).
% Пример 2: arcsinx(0.7, 12, Result, Error).
% Пример 3: arcsinx(0.1, 90, Result, Error).
% Пример 4: arcsinx(-0.52, 17, Result, Error).
% Пример 5: arcsinx(-1, 5, Result, Error).