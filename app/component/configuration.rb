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
	class Configuration < Lissio::Component
		def self.title
			'Configuration'
		end

		def self.icon
			'icon.png'
		end

		on 'page:unload' do
			Application.size         = element.at_css('.size td:nth-child(2) select').value
			Application.state[:show] = element.at_css('.show span').inner_text == 'No'
		end

		on :change, '.size td:nth-child(2) select' do |e|
			update
		end

		on :click, '.show span' do |e|
			if e.on.inner_text == 'Yes'
				e.on.inner_text = 'No'
			else
				e.on.inner_text = 'Yes'
			end
		end

		on :render do
			element.at_css(".size td:nth-child(2) select option[value='#{Application.size}']")[:selected] = :selected
			element.at_css('.show span').inner_text = Application.show? ? 'No' : 'Yes'

			update
		end

		def update
			element.at_css('.size td:nth-child(2) .value').inner_text =
				element.at_css('.size td:nth-child(2) select').value.capitalize
		end

		tag class: :configuration

		html do
			table do
				tr.size do
					td 'Interface Size :'
					td do
						div.value 'Normal'

						select do
							option.value(:small)  >> 'Small'
							option.value(:normal) >> 'Normal'
							option.value(:large)  >> 'Large'
							option.value(:larger) >> 'Larger'
						end
					end
				end

				tr.show do
					td 'In-Game Only :'
					td do
						span
					end
				end
			end
		end

		css do
			rule 'table' do
				rule 'td' do
					position :relative
					white space: :nowrap

					rule '&:first-child' do
						padding right: 7.px
					end

					rule 'select' do
						position :absolute
						top 0
						left 0
						opacity 0
					end

					rule 'input' do
						background :transparent
						border 0
						display 'inline-block'
						width 1.ch

						color :white
						text shadow: (', 0 0 2px black' * 10)[1 .. -1] +
							           (', 0 0 1px black' * 10)

						rule '&:focus' do
							outline :none
						end
					end
				end
			end
		end
	end
end
