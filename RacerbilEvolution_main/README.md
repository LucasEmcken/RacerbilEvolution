**Valg af løsning:**

Til at løse problemstillingen udformede jeg min egen kunstige intelligens, der bygger på et
Deep Feedforward netværk, der består af 5 lag, 1 input layer, 3 hidden layers, og det sidste
output lag. Til at akkomoderer det nye netværk har jeg også lavet nogle mere komplicerede
sensorer, der viser afstanden fra banens grænser, samt en ny bil, der tager hensyn til
vejgreb og motorkraft, når den skal køre, i håbet om at opnå en mere realistisk simulering.

**Sensorer/Input layer**

Sensoren på bilen fungerer ved, at de peger i en bestemt retning, relativ til bilens retning, og
returnerer afstanden fra bilen til muren. x antal (15 pr. default) sensorerne bliver placeret
jævnt over de 180 grader, der spænder bilens front. Da det der er bag bilen ikke er så
relevant, har jeg valgt at undlade dem til fordel for computerkraft og en mere konsistent
model.

**Hidden Layers**

De skjulte lag har hhv 16, 8 og 4 neuroner i hvert lag, som der forbinder til alle
neuroner/input lag bagud. dvs. at hvert neuron har det antal forbindelser bagud, som der er
lag bagud. Hver forbindelse har fået tildelt en tilfældig ‘weight’, som der bliver multipliceret
med det forbundne lags værdi, og hvert neuron har et tilfældigt ‘bias’, som til sidst bliver
adderet inde i aktivering funktionen.

**Output layer:**

Det sidste layer i det neurale netværk, består af 2 neuroner, som der fungerer ens med
neuronerne i de skjulte lag. I stedet for at føre hen til endnu et neuron, bliver de to tal ført
ned i bilens drive funktion, som tager 2 argumenter, en gas/bremse værdi og en roterings
værdi. Disse værdier bestemmer altså hvordan bilen skal køres

**Aktivering Funktion**

Som aktiverings funktion har jeg i alle lag valgt, for simplicitetens skyld (og fordi jeg er
doven), brugt en hyperbolsk tangens, som der fastlåser værdimængden mellem -1 og 1,
dette betyder at bilerne ikke kan give 120%.

**Genetisk Algoritme**

For at formere bilerne, konstruerer jeg en array liste, som der på baggrund af fitness
indsætter bilerne i listen. 2 Biler bliver så valgt til at formerer sig (Hvis i har set ‘biler’ filmen
fra disney ved i sådan cirka hvordan det fungerer), hvis gener bliver opdelt og samlet til en
barnebil, der så får sine weights og biases i det neurale netværk muteret på baggrund af
chance.

**Fitness**

For at vurdere bilernes fitness, har jeg opstillet en række checkpoints langs banen, som
bilerne køre ind i for at få en +1 højere fitness score. Den første bil der færdiggør en omgang
belønnes med den saftige gevinst af +5 fitness, og den nye generation bliver igangsat
gennem den genetiske algoritme.

**Drive funktion**

Bilernes drive funktion tager 2 inputs, gas/bremse og rotering, og på baggrund af dem
udregner, hvor og hvordan bilen skal køres. Bilen roteres med rotering, gennem gassen får
den tildelt en kræft i den retning den peger. Når bilen skal dreje laver en grov simulering af
vejgreb baseret på bilens hastighedsvektor sammenlignet med retningen for bilen. Jeg
tilføjer dernæst en kraft modsatrettet, for at holde bilen på banen. Hvis bilen overskrider
dens greb evner, bliver den modsatrettede kraft reduceret, og bilen vil skride ud til den enten
genvinder kontrollen, eller ryger af banen


