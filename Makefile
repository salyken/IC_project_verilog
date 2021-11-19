
ps:
	iverilog -g2012 -o pixelSensor -c pixelSensor.fl
	vvp -n pixelSensor

psfsm:
	iverilog -g2012 -o pixelSensorFsm -c pixelSensorFsm.fl
	vvp -n pixelSensorFsm

pstate:
	iverilog -g2012 -o pixelState -c pixelState.fl
	vvp -n pixelState

pa:
	iverilog -g2012 -o pixelArray -c pixelArray.fl
	vvp -n pixelArray

ptop:
	iverilog -g2012 -o pixelTop -c pixelTop.fl
	vvp -n pixelTop

ysfsm: synth
	dot pixelSensorFsm.dot -Tpng > pixelSensorFsm.png

ysstate: synthstate
	dot pixelState.dot -Tpng > pixelState.png

synth:
	yosys pixelSensorFsm.ys

synthstate:

	yosys pixelState.ys

test: ps psfsm synth

testing: pa pstate synthstate


