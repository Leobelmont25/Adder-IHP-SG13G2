export DESIGN_NICKNAME = adder
export DESIGN_NAME = adder
export PLATFORM    = ihp-sg13g2

export VERILOG_FILES = $(sort $(wildcard /opt/OpenROAD-flow-scripts/flow/teste1/*.v))
export SDC_FILE      = /opt/OpenROAD-flow-scripts/flow/teste1/constraint.sdc

#export CORE_UTILIZATION = 20
#export CORE_ASPECT_RATIO = 1

#export PLACE_DENSITY = 0.65
#export TNS_END_PERCENT = 100
export DIE_AREA = 0.0 0.0 1370.0 1370.0
export CORE_AREA = 390.0 390.0 980.0 980.0
export USE_FILL = 1
