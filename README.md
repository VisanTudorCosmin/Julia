# Julia

## Obiectiv

Scopul acestui proiect este de a implementa o metoda interactiva prin care putem descoperi si vizualia multimea Julia pentru functia `f(z) = z^2 + c` unde c este un numar complex ce va varia in functie de pozitia cursorului in fereastra aplicatiei.

## Fractali

Cuvantul “fractal” a fost introdus de matematicianul Benoit Mandelbrot in 1975 si provine din latinescul “fractus”, care inseamna spart sau fracturat.

Fractali sunt forme geometrice descrise cu ajutorul ecuatiilor matematice care au urmatoarele proprietatii:

1. **auto-similar**: atunci când o parte a unei figuri sau a unui contur poate fi văzută ca o replică a întregului, la o scară mai mică
2. **complexitate infinita**: prin magnificare oricarei parti dintr-un fractal structura se pastreaza si este la fel de complexa ca la orice magnificatie
3. **definitie simpla**: prin reguli simple se ajunge la structuri complexe, de obicei prin reguli recursive

Exmemple de fractali:

1. **Triunghiul lui Sierpinski**: poate fi creat pornind cu un triunghi mare, echilateral, apoi tăind în mod repetat triunghiuri mai mici din centrul său.
2. **Curba lui von Kock**: este create prin divizarea unei linii in trei parti egale, construirea unui triunghi echilateral unde baza triunghiului este partea din mijloc a liniei divizare si stergerea segmentului care a format baza triunghiului
3. **curba Heighway**
4. **Multimea lui Cantor**

<p float="left" align="middle">
	<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Sierpinski_triangle.svg/1200px-Sierpinski_triangle.svg.png"  width="30%">
	<img src="https://1.bp.blogspot.com/-qJf-vcR1lZM/UQadoc4jnII/AAAAAAAAFUs/-m8q8Kqqlq4/s1600/curba+fulgul+de+zapada.jpg"  width="30%">
</p>


Pentru a rula aplicatia avem nevoie ca Haskell si stack sa fie instalate pe calculator. Putem face acest lucru urmand pasii de [aici](https://docs.haskellstack.org/en/stable/).

Programul afiseaza imaginea generata de functia f(z) = z^2 + c, unde c poate sa fie variant in functie locul unde se afla cursorul pe fereastra aplicatie. 