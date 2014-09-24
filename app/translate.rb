#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Translate
	class Translation
		def initialize(string, &block)
			@string = string
			@to     = {}

			instance_exec(&block)
		end

		%w[en de es fr ko zh].each {|lang|
			define_method lang do |value = nil|
				if value
					@to[lang] = value
				else
					@to[lang]
				end
			end
		}

		def [](lang)
			@to[lang] || @string
		end
	end

	class << self
		def all
			@t ||= {}
		end

		def translate(string, to = Application.language || :en)
			return string if all[string].nil?

			all[string][to] || string
		end

		alias t translate

		def define(string, &block)
			all[string] = Translation.new(string, &block)
		end
	end

	# Titles
	define 'Dungeons' do
		es 'Mazmorras'
		fr 'Donjons'
		de 'Verliese'
	end

	define 'Fractals' do
		es 'Fractales'
		fr 'Fractales'
		de 'Fraktal'
	end

	define 'Crafting' do
		es 'Crafteo'
		fr 'Artisanat'
		de 'Handwerk'
	end

	define 'World Bosses' do
		es 'Jefes de Mundo'
		de 'Weltbosse'
	end

	define 'Options' do
		es 'Opciones'
		fr 'Options'
		de 'Optionen'
	end

	# Options
	define 'Interface Size' do
		es 'Tamaño de la Interfaz'
		fr "Taille de l'Interface"
		de 'Interface-Größe'
	end

	define 'Small' do
		es 'Pequeño'
		fr 'Petite'
		de 'Klein'
	end

	define 'Normal' do
		es 'Normal'
		fr 'Normale'
		de 'Normal'
	end

	define 'Large' do
		es 'Grande'
		fr 'Grande'
		de 'Groß'
	end

	define 'Larger' do
		es 'Máximo'
		fr 'Plus Grande'
		de 'Größer'
	end

	define 'In-Game Only' do
		es 'Sólo en el Juego'
		fr 'Dans le Jeu Seulement'
		de 'Nur im Spiel'
	end

	define 'Yes' do
		es 'Sí'
		fr 'Oui'
		de 'Ja'
	end

	define 'No' do
		es 'No'
		fr 'Non'
		de 'Nein'
	end

	define 'Language' do
		es 'Idioma'
		fr 'Langue'
		de 'Sprache'
	end

	# Crafting
	define 'Ascended Materials' do
		es 'Materiales Ascendidos'
		fr 'Matériaux Élevés'
		de 'Aufgestiegene Materialien'
	end

	define 'Lump of Mithrillium' do
		es 'Trozo de Mithrilio'
		fr 'Morceau de Mithrillium'
		de 'Mithrilliumbrocken'
	end

	define 'Spool of Silk Weaving Thread' do
		es 'Carrete de Hilo de Seda Para Tejer'
		fr 'Bobine de Fil de Soie à Tisser'
		de 'Spule Seidenwebfaden'
	end

	define 'Spool of Thick Elonian Cord' do
		es 'Carrete de Hilo Grueso Eloniano'
		fr 'Bobine de Corde Èlonienne Épaisse'
		de 'Spule Dicker Elonischer Schnur'
	end

	define 'Glob of Elder Spirit Residue' do
		es 'Pegote de Residuo de Espíritus Ancentrales'
		fr "Boule de Résidu d'Esprit Ancestral"
		de 'Klumpen von Rückständen des Ältesten-Geists'
	end

	define 'Mawdrey' do
		es 'Mawdrey'
		fr 'Maudrey'
		de 'Maultraud'
	end

	define 'Clay Pot' do
		es 'Maceta de Barro'
		fr 'Pot en Glaise'
		de 'Tontopf'
	end

	define 'Heat Stone' do
		es 'Piedra de Calor'
		fr 'Pierre de Chaleur'
		de 'Hitzestein'
	end

	define 'Grow Lamp' do
		es 'Lámpara de Crecimiento'
		fr 'Lampe de Croissance'
		de 'Wachstumslampe'
	end

	define 'Plate of Meaty Plant Food' do
		es 'Plato de Abono Carnoso'
		fr "Assiette d'Engrais à la Viande"
		de 'Teller mit Fleischiger Pflanzennahrung'
	end

	define 'Plate of Piquant Plant Food' do
		es 'Plato de Abono Picante'
		fr "Assiette d'Engrais Épicé"
		de 'Teller mit Schmackhafter Pflanzennahrung'
	end

	define 'Miscellaneous' do
		es 'Miscelánea'
		fr 'Divers'
		de 'Verschieden'
	end

	define 'Charged Quartz Crystal' do
		es 'Cristal de Cuarzo Cargado'
		fr 'Cristal de Quartz Chargé'
		de 'Aufgeladener Quarzkristall'
	end

	# World Bosses
	define 'Low' do
		es 'Bajo'
		fr 'Faible'
		de 'Niedrig'
	end

	define 'Standard' do
		es 'Estándar'
		fr 'Standard'
		de 'Standard'
	end

	define 'Hardcore' do
		es 'Hardcore'
		fr 'Hardcore'
		de 'Hardcore'
	end

	define 'Off-Schedule' do
		es 'Fuera De Horario'
		fr 'Hors Calendrier'
		de 'Off-Zeitplan'
	end

	define 'Temple' do
		es 'Templo'
		fr 'Temple'
		de 'Tempel'
	end

	define 'Shadow Behemot' do
		es 'Behemot De Las Sombras'
		fr 'Béhèmoth Des Ombres'
		de 'Schatten Behemot'
	end

	define 'Fire Elemental' do
		es 'Elemental De Fuego'
		fr 'Élémentaire De Feu'
		de 'Feuerelementar'
	end

	define 'Great Jungle Wurm' do
		es 'Gran Sierpe De La Selva'
		fr 'Grande Gulvre De La Jungle'
		de 'Großer Dschunglewurm'
	end

	define 'Svanir Shaman' do
		es 'Jefe Chamán Svanir'
		fr 'Chef Chamane De Svanir'
		de 'Schamanenoberhaupt Der Svanir'
	end

	define 'The Shatterer' do
		es 'El Asolador'
		fr 'Le Destructeur'
		de 'Der Zerschmetterer'
	end

	define 'Golem Mark I I' do
		es 'Gólem Serie I I'
		fr 'Golem Marque I I'
		de 'Golem Typ I I'
	end

	define 'Claw Of Jormag' do
		es 'Garra De Jormag'
		fr 'Griffe De Jormag'
		de 'Klaue Von Jormag'
	end

	define 'Admiral Taidha Covington' do
		es 'Almirante Taidha Covington'
		fr 'Amirale Taidha Covington'
		de 'Admiral Taidha Covington'
	end

	define 'Modniir Ulgoth' do
		es 'Ulgoth Modniir'
		fr 'Ulgoth Le Modniir'
		de 'Modniir Ulgoth'
	end

	define 'Megadestroyer' do
		es 'Megadestructor'
		fr 'Mégadestructeur'
		de 'Megazerstörer'
	end

	define 'Triple Trouble' do
		es 'Problema x3'
		fr 'Triple Terreur'
	end

	define 'Tequatl The Sunless' do
		es 'Tequatl El Sombrío'
		fr 'Tequatl Le Sans-Soleil'
		de 'Drelfacher Ärger'
	end

	define 'Karka Queen' do
		es 'Reina Karka'
		fr 'Reine Karka'
		de 'Karka Königin'
	end

	define 'Eye Of Zhaitan' do
		es 'Ojo de Zhaitan'
		fr 'Oeil de Zhaitan'
	end

	define 'Gates Of Arah' do
		es 'Puertas De Arah'
		fr "Portes D'Arah"
	end

	define 'Rhendak The Crazed' do
		es 'Rhendak El Loco'
		fr 'Rhendak Le Fou'
	end

	define 'Foulbear Chieftain' do
		es 'Corral Osoinmundo'
		fr "Kraal D'Oursefol"
	end

	define 'Dredge Commissar' do
		es 'Comisario Draga'
		fr 'Commissaire Draguerre'
	end

	define 'Fire Shaman' do
		es 'Chamán De Fuego'
		fr 'Chamane De Feu'
	end

	# Help & About
	define :help do
		en <<-MD.gsub(/^\t{3}/m, '')
			Daily Dolly is developed by **meh.6784** and the source is available on
			[GitHub](https://github.com/meh/dolly).

			General
			=======
			Daily Dolly is designed to help you keep track of everything time-gated
			on a daily basis that isn't somehow provided by the standard GW2 UI, this
			includes dungeons, fractals, crafting and world bosses.

			To minimize the window double click the icon on the top left, keep in
			mind this icon will change depending on the section you're viewing but
			its functionality won't change.

			To move the window around click and drag the icon mentioned above.

			To access a section, click on the title next to the icon and select the
			section from the dropdown menu.

			To access the options panel click on the gear icon on the top
			right.

			Dungeons
			========
			Keep track of the dungeon paths you've done, including earnings in gold,
			silver and tokens.

			Clicking on a path will mark it as done, and update the earnings at the
			bottom.

			Fractals
			========
			Keep track of the fractal levels you've done, including earnings in gold,
			silver, fractal relics and pristine fractal relics.

			Clicking on a level will mark it as done, and update the earnings at the
			bottom.

			Crafting
			========
			Keep track of the various time-gated craftables, this includes ascended
			mats, items for Mawdrey and miscellanea.

			Clicking on a crafting item will mark it as done.

			World Bosses
			============
			Keep track of the various world bosses in the world, including the
			off-schedule ones.

			Clicking on the waypoint icon will copy the closest waypoint to the
			clipboard.

			Clicking on the world boss name will mark it as done.

			A green timer represents hours and minutes remaining before the
			activation window begins, when one minute is left it will start blinking.

			During the event window the timer represents minutes and seconds passed
			since its beginning, it will be orange during warmup, red during its
			duration, and it will start blinking when it ended.

			*The warmup and duration times are approximations.*

			Options
			=======
			There are various options to adapt Daily Dolly to your liking.

			- `Interface Size` should be the same you configured Guild Wars 2 with.
			- `In-Game Only` allows you to show the interface either only while in
			  game or even on your desktop.
			- `Language` allows you to change the language from a list of GW2
			  supported languages.
		MD

		es <<-MD.gsub(/^\t{3}/m, '')
			Daily Dolly ha sido desarrollado por **meh.6784** y la fuente está
			disponible en [GitHub](https://github.com/meh/dolly).

			General
			=======
			Daily Dolly ha sido diseñado para ayudarte a mantener un registro diario,
			que de alguna manera no está proporcionado por el GW2 UI estándar, esto
			incluye mazmorras, fractales, crafteo y jefes de mundo.

			Para minimizar la ventana, haz doble clic en el icono arriba a la
			izquierda. Ten en cuenta que el icono cambiará dependiendo de la sección
			que estés visualizando, pero el funcionamiento seguirá siendo el mismo.

			Para mover la ventana alrededor, haz clic y arrastra el icono mencionado
			anteriormente.

			Para acceder a una sección, haz clic en el titulo junto al icono y
			selecciona un apartado del menú desplegable.

			Para acceder al panel de opciones, haz clic en el icono del
			engranaje, arriba a la derecha.

			Mazmorras
			=========
			Para mantener un seguimiento de las rutas de mazmorras que has concluido,
			incluyendo los ingresos de oro, plata y chapas.

			Clicando en una ruta, la marcará como finalizada, y actualizará las
			ganancias en la parte inferior.

			Fractales
			=========
			Para llevar un seguimiento de los niveles de fractales que has realizado,
			incluyendo las ganancias de oro, plata, reliquias fractales y reliquias
			fractales prístinas.

			Clicando en un nivel, la marcará como finalizado, y actualizará las
			ganancias en la parte inferior.

			Crafteo
			=======
			Para mantener un registro diario de varios crafteables, incluyendo
			materiales ascendidos, artículos para Mawdrey y otros.

			Haciendo clic en un crafteable lo marcará como adquirido.

			Jefes de Mundo
			==============
			Para mantener el seguimiento de varios jefes de mundo, incluido los que
			están fuera de horario.

			Clicando en el icono del punto de ruta, éste se copiará en el
			portapapeles.

			Clicando en el nombre del jefe de mundo, se marcará como finalizado.

			El temporizador verde representa las horas y minutos restantes antes que
			empiece la activación del evento. Cuando falte un minuto, empezará a
			parpadear.

			Durante el evento, el temporizador representará los minutos y segundos
			pasados desde su comienzo. Será de color naranja durante los pre eventos,
			rojos durante el evento principal, y empezará a parpadear cuando esté
			terminando.

			*Los pre eventos y la duración son aproximados.*

			Opciones
			========
			Hay varias opciones para adaptar Daily Dolly a tus preferencias.

			- `Tamaño de la interfaz` debería ser el mismo que tu propia
			  configuración de Guild Wars 2.
			- `Solo en el juego` te permite mostrar la interfaz solo dentro del juego
			  o también en el escritorio.
			- `Idiomas` te permite cambiar los idiomas, pudiendo elegir los que están
			  disponibles en GW2.
		MD

		de <<-MD.gsub(/^\t{3}/m, '')
			Daily Dolly wird von **meh.6784** entwickelt und der Quelltext ist
			verfügbar auf [GitHub](https://github.com/meh/dolly).

			Allgemein
			=======
			Daily Dolly hilft dir, den Überblick über alle einmal pro Tag verfügbaren
			Dinge zu behalten, die nicht bereits vom standardmäßigen GW2
			Userinterface bereitgestellt werden. Das beinhaltet Verliese, Fraktale,
			Handwerk und Weltbosse.

			Um das Fenster zu minimieren, klicke auf das Symbol oben links. Denk
			daran, dass sich dieses Symbol abhängig vom betrachteten Untermenü
			verändert, seine Funktion ändert sich jedoch nicht.

			Um das Fenster zu bewegen, klicke und ziehe das oben beschriebene Symbol.

			Um ein Untermenü aufzurufen, klicke auf den Titel neben dem Symbol und
			wähle das gewünschte Untermenü aus der Dropdown-Liste aus.

			Um zu den Optionen zu gelangen, klicke auf das Zahnrad oben rechts.

			Verliese
			========
			Behalte den Überblick über die Wege, die du in einem Verlies beendet
			hast, inklusive Gold-, Silber- und Tokenverdienste.

			Klicke auf einen Weg, um ihn als beendet zu markieren und die Verdienste
			unten zu aktualisieren.

			Fraktale
			========
			Behalte den Überblick über die Fraktallevel, die du absolviert hast,
			inklusive deiner Verdienste in Gold, Silber, Fraktal-Relikten und
			Makellosen Fraktal-Relikten. 

			Klicke auf ein Level um es als beendet zu markieren und die Verdienste
			unten zu aktualisieren.

			Handwerk
			========
			Behalte den Überblick über die verschiedenen einmal pro Tag herstellbaren
			Gegenstände. Das beinhaltet aufgestiegene Materialien, Gegenstände für
			Mawdrey und sonstiges.

			Klicke auf einen Handwerksgegenstand, um ihn als erledigt zu markieren.

			Weltbosse
			============
			Behalte den Überblick über die verschiedenen Weltbosse in der Welt,
			inklusive der nicht auf dem Zeitplan vermerkten.

			Klicke auf das Wegpunktsymbol um den nächstgelegenen Wegpunkt in die
			Zwischenablage zu kopieren.

			Klicke auf den Namen eines Weltbosses, um ihn als erledigt zu markieren.

			Ein grüner Zähler zeigt die verbleibenden Stunden und Minuten bevor der
			Aktivierungszeitraum beginnt. Wenn nur noch eine Minute übrig ist, wird
			er anfangen zu blinken.

			Während das Eventzeitraums zeigt der Zähler die seit Beginn des Zeitraums
			vergangenen Minuten und Sekunden. Der Zähler ist während der Aufwärmphase
			orange, rot während das Event läuft und beginnt nach seiner Beendigung zu
			blinken.

			*Die Aufwärm- und Laufzeiten sind Schätzungen.*

			Optionen
			=============
			Es gibt verschiedene Optionen um Daily Dolly nach deinem Geschmack
			anzupassen.

			- `Interface Size` sollte die gleiche wie in deinen Guild Wars 2
			  Einstellungen sein.
			- `In-Game Only` erlaubt dir, die Benutzeroberfläche entweder nur im
			  Spiel, oder auch auf deinem Desktop anzuzeigen.
			- `Language` erlaubt dir, eine Sprache aus einer Liste von GW2
			  unterstützten Sprachen auszuwählen.
		MD
	end
end

T = Translate
