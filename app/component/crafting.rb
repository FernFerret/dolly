#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Component
	class Crafting < Lissio::Component
		def self.title
			'Crafting'
		end

		def self.icon
			'crafting.png'
		end

		class Group < Lissio::Component
			class Material < Lissio::Component
				def initialize(name, icon)
					@name      = name
					@materials = Materials.new
					@icon      = icon
				end
	
				def done?
					@materials.done?(@name)
				end

				def done
					@materials.done(@name)
				end

				def reset
					@materials.reset(@name)
				end

				on :click, 'img, .name' do
					if done?
						reset
						element.remove_class :done
					else
						done
						element.add_class :done
					end
				end
	
				on :render do
					if done?
						element.add_class :done
					end
				end

				tag name: :table, class: :material
	
				html do |_|
					_.tr do
						_.td do
							_.img.src(@icon)
						end

						_.td.name T.t(@name)
					end
				end
	
				css do
					rule 'td' do
						vertical align: :top
					end

					rule 'img' do
						width 16.px
						height 16.px
	
						border 1.px, :solid, :black
						border radius: 5.px
						box shadow: [0.px, 0.px, 5.px, 0.px, rgba(50, 50, 50, 0.75)]

						margin right: 5.px

						position :relative
						top 2.px
					end

					rule '.name' do
						line height: 24.px
					end

					rule '&.done' do
						rule '.name' do
							text decoration: 'line-through'
						end
					end
				end
			end

			def initialize(title, materials)
				@title     = title
				@materials = materials
			end

			def open?
				Application.state["crafting.#@title"]
			end

			def open!
				element.add_class :open
				Application.state["crafting.#@title"] = true
			end

			def close!
				element.remove_class :open
				Application.state.delete("crafting.#@title")
			end

			on :click, '.title, .arrow' do |e|
				if open?
					close!
				else
					open!
				end
			end

			on :render do
				if open?
					open!
				end
			end

			html do |_|
				_.div.title T.t(@title)
				_.div.arrow do
					_.img.minus
					_.img.plus
				end

				_.div.materials do
					@materials.each {|name, icon|
						_ << Material.new(name, icon)
					}
				end
			end

			css do
				position :relative

				rule '.materials' do
					display :none

					rule '.material:last-child' do
						padding bottom: 10.px
					end
				end

				rule '&.open .materials' do
					display :block
				end

				rule '.arrow' do
					position :absolute
					top 3.px
					left -20.px

					rule '.minus' do
						content url('img/minus.png')
						filter grayscale(100.%)
						width 12.px
					end
	
					rule '.plus' do
						content url('img/plus.png')
						filter grayscale(100.%)
						width 12.px
					end
				end

				rule '.arrow .minus' do
					display :none
				end

				rule '&.open .arrow' do
					rule '.plus' do
						display :none
					end

					rule '.minus' do
						display 'inline-block'
					end
				end

				rule '.title' do
					font size: 18.px
					margin bottom: 5.px
				end
			end
		end

		html do
			self << Group.new('Ascended Materials',
				'Lump of Mithrillium'          => 'img/craft/lump-of-mithrillium.png',
				'Spool of Silk Weaving Thread' => 'img/craft/spool-of-silk-weaving-thread.png',
				'Spool of Thick Elonian Cord'  => 'img/craft/spool-of-thick-elonian-cord.png',
				'Glob of Elder Spirit Residue' => 'img/craft/glob-of-elder-spirit-residue.png')

			self << Group.new('Mawdrey',
				'Clay Pot'                    => 'img/craft/clay-pot.png',
				'Heat Stone'                  => 'img/craft/heat-stone.png',
				'Grow Lamp'                   => 'img/craft/grow-lamp.png',
				'Plate of Meaty Plant Food'   => 'img/craft/plate-of-meaty-plant-food.png',
				'Plate of Piquant Plant Food' => 'img/craft/plate-of-piquant-plant-food.png')

			self << Group.new('Miscellaneous',
				'Charged Quartz Crystal' => 'img/craft/charged-quartz-crystal.png')
		end
	end
end
