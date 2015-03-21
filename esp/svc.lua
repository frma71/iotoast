a=0
af=-1
limit = 550
toasting = true
tup=6000
tdown=6400


function toast()
   tmr.alarm(0, 1000, 1,
	     function() 
		a = adc.read(0)
		if(af == -1) then af = a end
		
		af = a; --(15*af+a)/16
		print(af)
		if(isdown and af > limit) then
		   up()
		   tmr.stop(0)
		end
	     end)
   down()
end

function sstop()
   pwm.stop(1)
   print("Stop")
end

-- Miliseconds times 100
function sset(us)
   pwm.setup(1, 100, 1024/(10000/us))
   pwm.start(1)
   print("Start",us)
end


function upt(t)
   sset(1000)
   tmr.alarm(1,t, 0, sstop)
end

function downt(t)
   sset(3000)
   tmr.alarm(1,t, 0, sstop)
end

function up() 
   isdown=false 
   upt(tup)
end

function down(t) 
   downt(tdown) 
   isdown=true 
end
