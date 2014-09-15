#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'opal'
require 'lissio'
require 'overwolf'

require 'browser/navigator'
require 'browser/storage'
require 'browser/delay'
require 'browser/interval'
require 'browser/console'

require 'dungeon'
require 'fractal'
require 'materials'
require 'boss'
require 'clipboard'

require 'component/dashboard'
require 'component/help'
require 'component/configuration'
require 'component/clipboard'

require 'component/dungeons'
require 'component/fractals'
require 'component/crafting'
require 'component/bosses'

$window.navigator.plugins.refresh

class Application < Lissio::Application
	def initialize(*)
		super

		router.fragment!

		route '/' do
			load Component::Dashboard.new
		end

		route '/help' do
			load Component::Help.new
		end

		route '/config' do
			load Component::Configuration.new
		end

		route '/dungeons' do
			load Component::Dungeons.new
		end

		route '/fractals' do
			load Component::Fractals.new
		end

		route '/crafting' do
			load Component::Crafting.new
		end

		route '/bosses' do
			load Component::Bosses.new
		end

		@clipboard = Component::Clipboard.new
	end

	def start
		super

		time = Time.new.getgm

		after ((23 - time.hour) * 60 * 60) + ((59 - time.min) * 60) + (59 - time.sec) + 1 do
			reset
			refresh
		end

		reset

		if Overwolf.available?
			Overwolf::Game.on :change do |u|
				next if show?

				if u.focus?
					next unless u.game.title == "Guild Wars 2"

					Overwolf::Window.current.then {|w|
						if u.game.focus?
							w.restore if @visibile
						else
							w.minimize
							@visible = w.visible?
						end
					}
				end
			end
		end
	end

	def reset
		time = Time.new.getgm
		hash = "#{time.year}-#{time.mon}-#{time.day}"

		if state[:last] != hash
			state[:last] = hash

			Dungeon.all.each(&:reset)
			Fractal.all.each(&:reset)
			Boss.all.each(&:reset)
			Materials.new.reset
		end
	end

	def load(component)
		@current.trigger 'page:unload' if @current
		@current = component

		if Component::Configuration === component || Component::Help === component
			element.at_css('.menu').add_class :special
		else
			element.at_css('.menu').remove_class :special
		end

		element.at_css('#container > .icon img')[:src] = 'img/' + component.class.icon
		element.at_css('#container > .header .title').inner_text = component.class.title
		element.at_css('#container > .content').inner_dom = component.render

		if el = element.at_css("#container > .header select option[value='#{@router.path}']")
			el[:selected] = :selected
		end

		@current.trigger 'page:load'
	end

	def clipboard
		@clipboard.new
	end
	expose :clipboard

	def state
		$window.storage(:state)
	end
	expose :state

	def size
		state[:size] || :normal
	end
	expose :size

	def size=(value)
		state[:size] = value
		element.remove_class(:small, :normal, :large, :larger)
		element.add_class(value)

		resize!
	end
	expose :size=

	def show?
		state[:show]
	end
	expose :show?

	def resize!
		width = case size
						when :small  then 260
						when :normal then 300
						when :large  then 320
						when :larger then 360
						end

		if Overwolf.available?
			Overwolf::Window.current.then {|w|
				w.resize(width, w.height)
			}
		else
			element.at_css('#container').style \
				margin: 20.px,
			  border: '2px solid black',
			  width: width.px,
			  height: 600.px
		end
	end

	on :render do
		element.add_class(size)
		resize!
	end

	on 'mouse:down' do
		next unless Overwolf.available?

		Overwolf::Window.current.then {|w|
			w.moving
		}
	end

	on :click, '#container > .icon' do
		if Overwolf.available?
			Overwolf::Window.current.then {|w|
				w.minimize
			}
		end
	end

	on :click, '.gear' do
		Application.navigate '/config'
	end

	on :click, '.question' do
		Application.navigate '/help'
	end

	on :click, '.back' do
		Application.navigate :back
	end

	on :change, '.header select' do |e|
		Application.navigate e.on.value
	end

	html do |_|
		_ << @clipboard

		_.div.container! do
			_.div.icon do
				_.img.src('img/icon.png')
			end

			_.div.header do
				_.div.title Component::Dashboard.title

				_.select do
					_.option.value('/')         >> Component::Dashboard.title
					_.option.value('/dungeons') >> Component::Dungeons.title
					_.option.value('/fractals') >> Component::Fractals.title
					_.option.value('/crafting') >> Component::Crafting.title
					_.option.value('/bosses')   >> Component::Bosses.title
				end

				_.div.menu do
					_.img.back
					_.img.question
					_.img.gear
				end

				_.div.style(clear: :both)
			end

			_.div.content
		end
	end

	css do
		font family: 'Text',
		     size:   14.px

		style '-webkit-font-smoothing', 'subpixel-antialiased'

		color :white
		text shadow: (', 0 0 2px black' * 10)[1 .. -1] +
		             (', 0 0 1px black' * 10)

		rule '#container' do
			background 'rgba(0, 0, 0, 0.01)'
			border bottom: [1.px, :solid, rgba(220, 220, 220, 0.7)]
			position :relative

			rule '& > .icon' do
				width 30.px
				height 30.px

				position :absolute
				top 3.5.px
				left 0

				rule 'img' do
					width 100.%
					height 100.%
				end
			end

			rule '& > .header' do
				position :relative
				margin 5.px, 0
				margin left: 33.px
				padding 10.px, 0
				padding bottom: 5.px

				rule '.title' do
					float :left
				end

				rule 'select' do
					position :absolute
					left 0
					top 10.px

					height 25.px

					opacity 0
				end

				rule '.menu' do
					vertical align: :middle

					position :absolute
					top 6.px
					right 5.px

					rule 'img' do
						cursor :pointer
						display 'inline-block'

						rule '&.gear' do
							content url('img/gear.png')
							width 23.px
							transform scale(0.9)

							position :relative
							top 3.px

							rule '&:hover' do
								content url('img/gear.active.png')
							end
						end

						rule '&.question' do
							content url('img/question.png')
							transform scale(0.9)

							position :relative
							top 1.px
							right 3.px

							rule '&:hover' do
								content url('img/question.active.png')
							end
						end

						rule '&.back' do
							content url('img/back.png')
							transform rotate(180.deg)

							position :relative
							top 4.px

							rule '&:hover' do
								content url('img/back.active.png')
							end
						end
					end

					rule '.back' do
						display :none
					end

					rule '&.special' do
						rule '.back' do
							display 'inline-block'
						end

						rule '.gear', '.question' do
							display :none
						end
					end
				end
			end

			rule '& > .content' do
				margin left: 35.px
			end
		end
	end

	css! do
		rule 'html', 'body' do
			width 100.%
			height 100.%

			overflow :hidden
			user_select :none
		end

		animation :blink do
			step 0.% do
				opacity 1
			end

			step 50.% do
				opacity 0
			end

			step 100.% do
				opacity 1
			end
		end

		rule '.blink' do
			animation :blink, 1.s, :linear, :infinite
		end

		rule 'body.small' do
			rule '.header' do
				rule '.title', 'h1' do
					font size: 17.px
				end
			end

			rule '.content' do
				font size: 15.px

				rule 'h1' do
					font size: 17.px
				end
			end
		end

		rule 'body.normal' do
			rule '.header' do
				rule '.title', 'h1' do
					font size: 17.px
				end
			end

			rule '.content' do
				font size: 15.px

				rule 'h1' do
					font size: 17.px
				end
			end
		end

		rule 'body.large' do
			rule '.header' do
				rule '.title', 'h1' do
					font size: 19.px
				end
			end

			rule '.content' do
				font size: 16.px

				rule 'h1' do
					font size: 19.px
				end
			end
		end

		rule 'body.larger' do
			rule '.header' do
				rule '.title' do
					font size: 20.px
				end
			end

			rule '.content' do
				font size: 17.px

				rule 'h1' do
					font size: 20.px
				end
			end
		end
	end
end
