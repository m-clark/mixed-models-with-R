* calculate linear predictor for estimating variance .
COMPUTE LinPred = -2.242+0.535*male-0.627*pped-0.296*msesc .
DESCRIPTIVES VARIABLES=LinPred /STATISTICS=MEAN STDDEV VARIANCE MIN MAX .
