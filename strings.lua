function data()
return {
	en = {
		mod_desc = [[
As you have probably experienced many times, building streets, tracks, stations and other objects can be very annoying if there are constant collision warnings in a densely built-up area. For assets/constructions, this can be bypassed using "[b]skipCollision=true[/b]", so you can build despite the collision (but don't get any feedback anymore). For streets/tracks this was not possible until now.

Now it is! With [b]Build with collision[/b] almost all problems that occur when building streets, tracks and constructions (collision, too much slope, too much curvature) can be ignored.

When building a proposal, a button [b][i]Build Anyway[/i][/b] is displayed to the right/above the mouse position, similar to the tooltip of [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2298331429]Track/Street Builder Info[/url], but of course only if the proposal is not feasible normally and is not "critical".
It can be a bit tricky to use, so a few hints:
[list]
[*]For streets and tracks it should be intuitive. The field appears as with Track/Street Builder Info and stays there (i.e. at the screen position and not at a location on the map). As long as the build suggestion remains displayed, you can click [b][i]Build Anyway[/i][/b]. Eventually with collisions and unwanted snapping, you have to work with the "new shift key" (default: C)
[*]With constructions/assets it gets a bit more fiddly, because the mouse is always at the building point. Then:
[olist]
[*]hold down right click
[*]navigate to the field
[*]release right click
[*]press button with left click
[/olist]
[*]With upgrades (streets/tracks) it gets more complicated, you can't move the mouse somewhere else without the building proposal disappearing. You have to "catch" the button and stay on the object to be upgraded at the same time. Therefore, the button is closer to the mouse position here.
[/list]

This opens up completely new possibilities for Schönbau. In addition, you don't have to turn off collision or change track parameters, you can still detect problems, but allow them specifically. On the other hand, you are then responsible for the collisions on overlapping traffic lanes.

With this, tracks on streets, streets on airports and many other ideas are possible.
Therefore, it would be great if other modders would develop special streets/tracks for this!
So e.g. invisible streets, streets with placeholder areas for streetcar tracks, tracks lowered to street level, ...

More Info: https://www.transportfever.net/index.php?thread/17979-build-with-collision/


[h3]If you like to support my mod development, you can donate here:[/h3]
[url=https://paypal.me/VacuumTubeTPF ][img]https://raw.githubusercontent.com/Vacuum-Tube/Advanced_Statistics_1/main/pictures/paypal.png [/img][/url]   [b]Thank you![/b]
]],
	},
	de = {
		mod_desc = [[
Wie ihr sicher schon oft erlebt habt, kann das Bauen von Straßen, Gleisen, Bahnhöfen und anderen Objekten sehr nervig werden, wenn es in einem zugebauten Gebiet zu dauernden Kollisionswarnungen kommt. Bei Assets/Konstruktionen lässt sich die Meldung mittels "[b]skipCollision=true[/b]" umgehen, man kann so trotz Kollision bauen (erhält aber auch keine Rückmeldung mehr). Für Straßen/Gleise war dies bis dato nicht möglich.

Jetzt schon! Mit [b]Build with collision[/b] können fast alle Probleme, die beim Bau von Straßen, Gleisen und Konstruktionen auftreten (Kollision, zu große Steigung, zu große Krümmung) ignoriert werden.

Dazu wird beim Bauvorschlag rechts/über der Mausposition das Feld [b][i]Trotzdem Bauen[/i][/b] angezeigt, ähnlich wie der Tooltip von [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2298331429]Track/Street Builder Info[/url], aber natürlich nur, wenn das Bauvorhaben nicht auf normalem Weg durchführbar ist und es nicht "critical" ist.
Die Bedienung kann etwas tricky sein, daher ein paar Hinweise:
[list]
[*]Bei Straßen und Gleisen sollte es intuitiv sein. Das Feld erscheint wie beim Track/Street Builder Info und bleibt dort allerdings auch (d.h. an der Bildschirmposition und nicht an einer Stelle der Karte). Solange der Bauvorschlag angezeigt bleibt, kann man [b][i]Trotzdem Bauen[/i][/b] klicken. Ggf muss man beim Verlegen mit Kollisionen und unerwünschtem Snappen mit der "neuen shift Taste" (default: C) arbeiten.
[*]Bei Konstruktionen/Assets wirds etwas fummeliger, da die Maus immer an der Stelle zum Platzieren ist. Dann:
[olist]
[*]rechte Maustaste gedrückt halten
[*]auf das Feld navigieren
[*]rechte Maustaste loslassen
[*]mit linker Maustaste Button drücken
[/olist]
[*]Bei Upgrades (Straßen/Gleise) wirds noch komplizierter, auch hier kann man mit der Maus nicht woanders hin, ohne dass der Bauvorschlag verschwindet. Man muss den Button gewissermaßen "einfangen" und gleichzeitig auf dem zu upgradenden Objekt bleiben. Daher ist der Button hier näher an der Mausposition.
[/list]

Dadurch ergeben sich völlig neue Möglichkeiten beim Schönbau. Außerdem muss man die Kollision nicht ausschalten oder die Parameter von Schienen ändern, sondern kann Probleme weiterhin erkennen, aber gezielt erlauben. Logischerweise ist man für Kollisionen auf überschneidenden Verkehrswegen dann selbst verantwortlich.

Auch Schienen auf Straßen, Straßen auf Flughäfen und viele weitere Ideen sind so möglich.
Dafür wäre es natürlich klasse, wenn andere Modder spezielle Straßen/Gleise hierfür entwickeln!
Also z.B. unsichtbare Straßen, Straßen mit Platzhalterbereichen für Tramschienen, Gleise auf Straßenhöhe abgesenkt, ...

Mehr Infos: https://www.transportfever.net/index.php?thread/17979-build-with-collision/
Anregungen: https://www.transportfever.net/index.php?thread/17995-unsichtbare-stra%C3%9Fen/


[h3]Wenn Du meine Mod Entwicklung unterstützen möchtest, würde ich mich über eine Spende freuen:[/h3]
[url=https://paypal.me/VacuumTubeTPF ][img]https://raw.githubusercontent.com/Vacuum-Tube/Advanced_Statistics_1/main/pictures/paypal.png [/img][/url]   [b]Danke![/b]
]],
		["Build Anyway"] = "Trotzdem Bauen",
	}
}
end