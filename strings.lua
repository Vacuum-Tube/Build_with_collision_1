function data()
return {
	en = {
		mod_desc = [[
As you have probably experienced very often, building streets, tracks, stations and other objects can be very annoying if there are many collision warnings in a densely built-up area. For assets/constructions, this can be bypassed using "[b]skipCollision=true[/b]", so you can build despite the collision, but don't get any feedback anymore. For streets/tracks this was not possible until now.

Now it is! With [b]Build with collision[/b] almost all problems that occur when building streets, tracks and constructions (collision, too much slope, too much curvature), can be ignored. When building a proposal which would normally not be applicable (but is not "critical"), a button [b][i]Build Anyway[/i][/b] is displayed.
[list]
[*]For streets and tracks, the button appears next to the cursor as with "Track/Street Builder Info". Eventually with collisions and unwanted snapping, you have to work with the "new shift key" (default: C).
[*]For constructions/assets, just click right mouse!
[*]Upgrades can now also be done with a simple right click.
[*] [i]Bulldoze with collision.[/i] Sometimes the game doesn't allow bulldozing (e.g. bridge pillar collision), which can be bypassed now. [u]DON'T use it when vehicles are isolated or in a depot![/u]
[/list]

This opens up completely new possibilities for Schönbau. In addition, you don't have to turn off collision or change track parameters, you can still detect issues, but allow them specifically. On the other hand, you are then responsible for the collisions on overlapping traffic lanes.
With this, tracks on streets, streets on airports and many other ideas are possible.
Therefore, it would be great if other modders would develop special streets/tracks for this! (e.g. invisible streets, streets with placeholder areas for streetcar tracks, tracks lowered to street level, ...)

[i]Thanks for all the positive feedback! I did not expect that the mod gets so popular. Here a few mods that have been building up on this:[/i]
[list]
[*][url=https://www.transportfever.net/filebase/index.php?entry/6495-kleines-unsichtbares-stra%C3%9Fenfahrzeugpot-und-unsichtbare-wege/ ]Invisible Ways and small invisible depot[/url]
[*][url=https://www.transportfever.net/filebase/entry/6517-gep%C3%A4ck-und-warentransporter-f%C3%BCr-den-flughafen/ ]Baggage and goods transporter for the airport[/url]
[*][url=https://www.transportfever.net/filebase/entry/6790-underpass-for-tracks-streets/ ]Underpass for Tracks & Streets[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2848415950 ]Parallel Tool[/url]
[/list]

More Info: https://www.transportfever.net/index.php?thread/17979-build-with-collision/

Source Code on [url=https://github.com/Vacuum-Tube/Build_with_collision_1 ]GitHub[/url]

[h3]If you like to support my mod development, you can donate here:[/h3]
[url=https://paypal.me/VacuumTubeTPF ][img]https://raw.githubusercontent.com/Vacuum-Tube/Advanced_Statistics_1/main/pictures/paypal.png [/img][/url]   [b]Thank you![/b]
]],
		bwC_RightClickBuild = "Rightclick for street/track construction",
		bwC_RightClickBuild_TT = "When building streets/tracks in general, activate the right mouse button as trigger",
	},
	de = {
		mod_desc = [[
Wie ihr sicher schon oft erlebt habt, kann das Bauen von Straßen, Gleisen, Bahnhöfen und anderen Objekten sehr nervig werden, wenn es in einem zugebauten Gebiet zu dauernden Kollisionswarnungen kommt. Bei Assets/Konstruktionen lässt sich die Meldung mittels "[b]skipCollision=true[/b]" umgehen, man kann zwar so trotz Kollision bauen, erhält aber auch keine Rückmeldung mehr. Für Straßen/Gleise war dies bis dato nicht möglich.

Jetzt schon! Mit [b]Build with collision[/b] können fast alle Probleme, die beim Bau von Straßen, Gleisen und Konstruktionen auftreten (Kollision, zu große Steigung, zu große Krümmung), ignoriert werden. Dazu wird beim Bauvorhaben, wenn es nicht auf normalem Weg durchführbar ist (und nicht "critical" ist), das Feld [b][i]Trotzdem Bauen[/i][/b] angezeigt.
[list]
[*]Bei Straßen und Gleisen erscheint der Button neben der Mausposition ähnlich wie beim "Track/Street Builder Info". Ggf muss man beim Verlegen mit Kollisionen und unerwünschtem Snappen mit der "neuen shift Taste" (default: C) arbeiten.
[*]Bei Konstruktionen/Assets einfach rechte Maustaste klicken!
[*]Upgrades können jetzt auch mit einem einfachen Rechtsklick ausgeführt werden.
[*] [i]Bulldoze with collision.[/i] Manchmal erlaubt das Spiel kein Bulldozen (z.B. Brückenpfeilerkollision), was hiermit umgangen werden kann. [u]NICHT benutzen wenn Fahrzeuge isoliert oder im Depot sind![/u]
[/list]

Dadurch ergeben sich völlig neue Möglichkeiten beim Schönbau. Außerdem muss man die Kollision nicht ausschalten oder die Parameter von Schienen ändern, sondern kann Probleme weiterhin erkennen, aber gezielt erlauben. Andererseits ist man für Kollisionen auf überschneidenden Verkehrswegen dann selbst verantwortlich.
Auch Schienen auf Straßen, Straßen auf Flughäfen und viele weitere Ideen sind so möglich.
Dafür wäre es natürlich klasse, wenn andere Modder spezielle Straßen/Gleise hierfür entwickeln! (z.B. unsichtbare Straßen, Straßen mit Platzhalterbereichen für Tramschienen, Gleise auf Straßenhöhe abgesenkt, ... )

[i]Danke für das viele positive Feedback! Dass die Mod so beliebt wird, hätte ich damals nicht gedacht. Hier ein paar Mods die inzwischen entstanden sind:[/i]
[list]
[*][url=https://www.transportfever.net/filebase/index.php?entry/6495-kleines-unsichtbares-stra%C3%9Fenfahrzeugpot-und-unsichtbare-wege/ ]Kleines unsichtbares Straßenfahrzeugpot und unsichtbare Wege[/url]
[*][url=https://www.transportfever.net/filebase/entry/6517-gep%C3%A4ck-und-warentransporter-f%C3%BCr-den-flughafen/ ]Gepäck- und Warentransporter für den Flughafen[/url]
[*][url=https://www.transportfever.net/filebase/entry/6790-underpass-for-tracks-streets/ ]Underpass for Tracks & Streets[/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2848415950 ]Parallel Tool[/url]
[/list]

Mehr Infos: https://www.transportfever.net/index.php?thread/17979-build-with-collision/

Source Code on [url=https://github.com/Vacuum-Tube/Build_with_collision_1 ]GitHub[/url]

[h3]Wenn Du meine Mod Entwicklung unterstützen möchtest, würde ich mich über eine Spende freuen:[/h3]
[url=https://paypal.me/VacuumTubeTPF ][img]https://raw.githubusercontent.com/Vacuum-Tube/Advanced_Statistics_1/main/pictures/paypal.png [/img][/url]   [b]Danke![/b]
]],
		["Build Anyway"] = "Trotzdem Bauen",
		["Bulldoze Anyway"] = "Trotzdem Bulldozen",
		["Upgrade Anyway"] = "Trotzdem Upgraden",
		["Click Right"] = "Rechts klicken",
		bwC_RightClickBuild = "Rechtsklick für Straßen/Gleisbau",
		bwC_RightClickBuild_TT = "Beim Straßen/Gleisbau generell die rechte Maustaste als Trigger aktivieren",
	}
}
end