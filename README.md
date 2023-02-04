# Aplicatie pentru afisarea multimii Julia

Profesor: Conf. univ. dr. ing. Radu URSIANU <br>
Student: Tudor-Cosmin VISAN

## Obiectiv

Scopul acestui proiect este de a implementa o metoda interactiva prin care putem descoperi si vizualia multimea Julia pentru functia `f(z) = z^2 + c` unde c este un numar complex ce va varia in functie de pozitia cursorului in fereastra aplicatiei.

## Fractali

Cuvantul “fractal” a fost introdus de matematicianul Benoit Mandelbrot in 1975 si provine din latinescul “fractus”, care inseamna spart sau fracturat.

Fractali sunt forme geometrice descrise cu ajutorul ecuatiilor matematice care au urmatoarele proprietatii:

1. **auto-similar**: atunci când o parte a unei figuri sau a unui contur poate fi văzută ca o replică a întregului, la o scară mai mică
2. **complexitate infinita**: prin magnificare oricarei parti dintr-un fractal structura se pastreaza si este la fel de complexa ca la orice magnificatie
3. **definitie simpla**: prin reguli simple se ajunge la structuri complexe, de obicei prin reguli recursive

Exemple de fractali:

1. **Triunghiul lui Sierpinski**: poate fi creat pornind cu un triunghi mare, echilateral, apoi tăind în mod repetat triunghiuri mai mici din centrul său.
2. **Curba lui von Kock**: este create prin divizarea unei linii in trei parti egale, construirea unui triunghi echilateral unde baza triunghiului este partea din mijloc a liniei divizare si stergerea segmentului care a format baza triunghiului
3. **curba Heighway**
4. **Multimea lui Cantor**

<p float="left" align="middle">
	<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Sierpinski_triangle.svg/1200px-Sierpinski_triangle.svg.png"  width="30%">
	<img src="https://1.bp.blogspot.com/-qJf-vcR1lZM/UQadoc4jnII/AAAAAAAAFUs/-m8q8Kqqlq4/s1600/curba+fulgul+de+zapada.jpg"  width="30%">
</p>


## Multimea Julia

Setul Julia poartă numele matematicianului francez Gaston Julia care le-a investigat proprietățile în jurul anului 1915 și a culminat cu celebra sa lucrare în 1918.

Multimea Julia este calculata pentru orice punct z=x+yi din planul numerelor complexe prin procesul iterativ de compunere a functiei `f(z) = z^2 + c` unde z este numar complex. Multimea este definita ca valorile z pentru care sirul f(f(f(..))) este o valoare marginita.

Pentru reprezentarea grafica a multimii Julia avem urmatori pasi; primul pas este de a calcula valoarea n pentru care lungimea vectorului din origine la  `f^n(z)` depaseste un anumit prag stabilit (ex: 2). Daca intr-un numar finit de pasi nu este depasit prag-ul atunci punctul face parte din multimea julia si va fi afisat ca atare. Accest proces de a descoperi valoarea n pentru care sirul de numere explodeaza este facut pentru fiecare pixel.

## Haskell

Pentru dezolvatarea aplicatiei a fost folosit limbajul de programare Haskell.

Haskell este un limbaj de programare modern, pur functional și non-strict. Este special conceput pentru a gestiona o gama larga de aplicatii, de la aplicatii numerice pana la cele grafice. Are o
sintaxa expresiva prin care se pot scrie solutii elegante la probleme foarte complexe. Au mai fost folosite si biblioteca grafica JuicyPixels pentru crearea imagini si biblioteca Gloss pentru interactiunea si afisarea ferestrei grafice.

Pentru a rula aplicatia avem nevoie ca Haskell si stack sa fie instalate pe calculator. Putem face acest lucru urmand pasii de [aici](https://docs.haskellstack.org/en/stable/).

Punctul central al aplicatiei noastre este metoda `playIO`  importanta din pachetul Gloss

<br>

<br>

```haskell
playIO :: Display
	   -> Color
	   -> Int
	   -> Stare
	   -> (Stare -> IO Picture)
	   -> (Event -> Stare -> IO Stare)
	   -> (Float -> Stare -> IO Stare)
	   -> IO ()

main :: IO ()
main = playIO (InWindow "Fractal Julia" (512, 512) (10, 10)) white 20 (Stare defaultImage (0,0)) afiseazaStare modificaStare calculeaazaImagineNoua
```

Metoda are 7 parametrii,
1. primul parametrul reprezinta modalitate prin care aplicatia va fi afisata, in cazul nostru va fi ca o fereastra de marime 512x512 pixeli si cu titlul "Fractal Julia"
2. al doilea parametru reprezinta culoarea de fundal a ferestrei
3. valoarea 20 reprezinta numarul de simulari pe secunda care vor fi executate
4. `Stare defaultImage (0,0)` este valoarea de start a aplicatiei care este definita de urmatoarea structura de date
```
data Stare = Stare Picture (Double,Double)
```
Structura Stare are doi parametri, primul Picture este imaginea ce va fi afisata si care este generata la fiecare cadru. Perechea `(Double,Double)` contine cele doua coordonate ale cursorului.
5. functia `afiseazaStare` genereaza imaginea finala care va fi afisata in fereastra
6. functia `modificaStare` primeste ca parametrii coordonatele cursorului si le transforma in valori normalizare
7. functia `calculeazaImagineNoua` genereaza imaginea multimii Julia 


Functia care ne calculeaza valoarea n pentru care un punct depaseste pragul stabilit este

```haskell
apartineInSetulJulia :: Double -> Double -> Double -> Double -> Int
apartineInSetulJulia !cx !cy !x !y = calculeaza x y 0
    where calculeaza x y n | n > 50 = n
          calculeaza x y n | x*x + y*y > 4 = n
          calculeaza !x !y !n = calculeaza (x*x - y*y + cx) (2*x*y + cy) (n + 1)
```

Metoda primeste ca parametrii 4 valori, primele doua reprezinta coordonatele constantei c, urmatoarele 2 reprezitna coordonatele punctului z. Calcularea propriu zisa a valori n este facuta de metoda calculeaza, metoda trateaza trei cazuri.
Primul caz in care s-a ajuns la numarul maxim de iteratii, in acest caz puncutl este considerata ca facand parte din multimea Julia. Al doilea caz in care magnitudinea vectorului (x,y) este mai mare decat 2 atunci este returnata valoarea n. In cazul in care nu au fost indeplinite nici o conditie atunci mai este iterata inca o data functia pentru noul punct rezultat.

Capturi din aplicatie:

<p float="left" align="middle">
	<img src="https://chimein.b-cdn.net/Imagine1.PNG" width="200px" height="200px">
	<img src="https://chimein.b-cdn.net/Imagine2.PNG" width="200px" height="200px">
	<img src="https://chimein.b-cdn.net/Imagine3.PNG" width="200px" height="200px">
</p>

## Bibliografie

1. <https://en.wikipedia.org/wiki/Julia_set>
2. <https://www.karlsims.com/julia.html>
3. <http://paulbourke.net/fractals/juliaset/>
4. <https://en.wikipedia.org/wiki/Sierpi%C5%84ski_triangle>