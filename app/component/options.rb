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
	class Options < Lissio::Component
		def self.title
			'Options'
		end

		def self.icon
			'icon.png'
		end

		on 'page:unload' do
			Application.size         = element.at_css('.size td:nth-child(2) select').value
			Application.language     = element.at_css('.language td:nth-child(2) select').value
			Application.state[:show] = element.at_css('.show span').inner_text == 'No'
		end

		on :change, 'select' do |e|
			update
		end

		on :click, '.show span' do |e|
			if e.on.inner_text == T.t('Yes')
				e.on.inner_text = T.t('No')
			else
				e.on.inner_text = T.t('Yes')
			end
		end

		on :render do
			element.at_css(".size td:nth-child(2) select option[value='#{Application.size}']")[:selected] = :selected
			element.at_css(".language td:nth-child(2) select option[value='#{Application.language}']")[:selected] = :selected
			element.at_css('.show span').inner_text = Application.show? ? T.t('No') : T.t('Yes')

			update
		end

		def update
			element.at_css('.size td:nth-child(2) .value').inner_text =
				element.at_css('.size td:nth-child(2) select').option.inner_text

			element.at_css('.language td:nth-child(2) .value').inner_text =
				element.at_css('.language td:nth-child(2) select').option.inner_text
		end

		tag class: :options

		html do
			table do
				tr.size do
					td T.t('Interface Size') + ' :'
					td do
						div.value T.t('Normal')

						select do
							option.value(:small)  >> T.t('Small')
							option.value(:normal) >> T.t('Normal')
							option.value(:large)  >> T.t('Large')
							option.value(:larger) >> T.t('Larger')
						end
					end
				end

				tr.show do
					td T.t('In-Game Only') + ' :'
					td do
						span
					end
				end

				tr.language do
					td T.t('Language') + ' :'
					td do
						div.value T.t('English')

						select do
							option.value(:en) >> 'English'
							option.value(:es) >> 'Español'
							option.value(:fr) >> 'Français'
							option.value(:de) >> 'Deutsch'
						end
					end
				end
			end
		end

		css do
			margin bottom: 5.px

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
