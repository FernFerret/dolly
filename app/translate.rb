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

		%w[de es fr ko zh].each {|lang|
			define_method lang do |value = nil|
				if value
					@to[lang] = value
				else
					@to[lang]
				end
			end
		}

		def en
			@string
		end

		def [](lang)
			@to[lang] || @string
		end
	end

	class << self
		def all
			@t ||= {}
		end

		def translate(string, to = Application.language || :en)
			return string if to == :en || all[string].nil?

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
		es 'Artesanía'
		fr 'Artisanat'
		de 'Handwerk'
	end

	define 'World Boss' do
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
end

T = Translate
