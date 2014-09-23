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
	class Bosses::Boss < Lissio::Component
		def initialize(parent, boss)
			@parent = parent
			@boss   = boss
		end

		def method_missing(*args, &block)
			@boss.__send__(*args, &block)
		end

		def timer?
			!times.empty?
		end

		def time
			time = Time.new.getgm
			now  = ::Boss::At.new(time.hour, time.min, time.sec)

			times.reduce {|prev, curr|
				if now.hours >= prev.hours && now.hours <= curr.hours
					unless now.hours == curr.hours && now.minutes > curr.minutes + 14
						return now, curr
					end
				end

				curr
			}

			return now, times.first
		end

		def timer(now, curr)
			el         = element.at_css('.timer')
			el_hours   = element.at_css('.timer .hours')
			el_minutes = element.at_css('.timer .minutes')
			el_seconds = element.at_css('.timer .seconds')

			el.remove_class :blink, :wait, :warmup, :active

			if now.hours == curr.hours && now.minutes >= curr.minutes
				minutes = now.minutes - curr.minutes
				seconds = now.seconds

				el_hours.inner_text   = '00'
				el_minutes.inner_text = '%02d' % minutes
				el_seconds.inner_text = '%02d' % now.seconds

				after    = minutes * 100 + seconds
				warmup   = self.warmup.minutes * 100 + self.warmup.seconds
				duration = self.duration.minutes * 100 + self.duration.seconds

				if after < warmup
					el.add_class :warmup
				elsif after < warmup + duration
					el.add_class :active
				else
					el.add_class :active
					el.add_class :blink
				end
			else
				el.add_class :wait

				if curr.hours < now.hours
					hours = 24 - now.hours + curr.hours
				else
					hours = curr.hours - now.hours
				end

				minutes = curr.minutes - now.minutes
				seconds = now.seconds

				if seconds > 0
					minutes -= 1
					seconds  = 60 - seconds
				end

				if minutes < 0
					hours   -= 1
					minutes  = 60 + minutes
				end
				
				el_hours.inner_text   = '%02d' % hours
				el_minutes.inner_text = '%02d' % minutes
				el_seconds.inner_text = '%02d' % seconds
			end
		end

		def tick
			el         = element.at_css('.timer')
			el_hours   = element.at_css('.timer .hours')
			el_minutes = element.at_css('.timer .minutes')
			el_seconds = element.at_css('.timer .seconds')

			hours   = el_hours.inner_text.to_i
			minutes = el_minutes.inner_text.to_i
			seconds = el_seconds.inner_text.to_i

			if el.class_names.include? :wait
				if seconds == 0
					seconds = 59

					if minutes == 0
						minutes = 59

						if hours == 0
							el.add_class :warmup
							el.remove_class :wait, :blink

							seconds = 0
							minutes = 0
						else
							hours -= 1
						end
					else
						minutes -= 1
					end
				else
					seconds -= 1

					if minutes == 0 && hours == 0
						el.add_class :blink
					end
				end
			else
				after    = minutes * 100 + seconds
				warmup   = self.warmup.minutes * 100 + self.warmup.seconds
				duration = self.duration.minutes * 100 + self.duration.seconds

				if after == warmup
					el.remove_class :warmup
					el.add_class :active
				elsif after == warmup + duration
					el.add_class :blink
				end

				if seconds == 59
					seconds  = 0
					minutes += 1
				else
					seconds += 1
				end

				# most events last 15 minutes
				if minutes == 15
					return timer(*time)
				end
			end

			el_hours.inner_text   = '%02d' % hours
			el_minutes.inner_text = '%02d' % minutes
			el_seconds.inner_text = '%02d' % seconds
		end

		on :click, '.waypoint' do |e|
			Application.clipboard.set(e.on.data[:waypoint])
		end

		on :click, '.timer, .name' do
			if done?
				reset
				element.remove_class :done
			else
				done
				element.add_class :done
			end
		end

		on 'page:load' do
			next unless timer?

			@tick = every 1 do
				tick
			end
		end

		on 'page:unload' do
			next unless timer?

			@tick.abort
		end

		on :render do
			if done?
				element.add_class :done
			end

			if timer?
				timer(*time)
			else
				element.add_class :off unless timer?
			end
		end

		tag name: :table, class: :boss

		html do |_|
			_.tr do
				_.td.waypoint do
					_.img.data(waypoint: waypoint)
				end

				_.td.timer do
					_.span.hours
					_.span.minutes
					_.span.seconds
				end

				_.td.name T.t(name)
			end
		end

		css do
			margin bottom: 3.px

			border spacing: 0,
			       collapse: :collapse

			rule '.waypoint' do
				padding right: 25.px
				vertical align: :top
				position :relative

				rule 'img' do
					position :absolute
					top -1.px
					left 2.px
					width 18.px
					height 18.px

					content url('img/waypoint.png')
				end

				rule '&:hover' do
					rule 'img' do
						content url('img/waypoint.active.png')
					end
				end
			end

			rule '&.off .timer' do
				display :none
			end

			rule '.timer' do
				vertical align: :top
				line height: 16.px

				padding right: 6.px

				rule '.hours::after' do
					content '":"'
				end

				rule '.seconds::before' do
					content '":"'
				end

				rule '&.wait' do
					text shadow: (', 0 0 2px #007a20' * 10)[1 .. -1] +
					             (', 0 0 1px #007a20' * 10)

					rule '.seconds' do
						display :none
					end
				end
	
				rule '&.warmup' do
					text shadow: (', 0 0 2px #ff6000' * 10)[1 .. -1] +
					             (', 0 0 1px #ff6000' * 10)

					rule '.hours' do
						display :none
					end
				end

				rule '&.active' do
					text shadow: (', 0 0 2px #b20000' * 10)[1 .. -1] +
					             (', 0 0 1px #b20000' * 10)

					rule '.hours' do
						display :none
					end
				end
			end

			rule '.name' do
				vertical align: :top
				line height: 16.px
			end

			rule '&.done' do
				rule '.name' do
					text decoration: 'line-through'
				end
			end
		end
	end
end
