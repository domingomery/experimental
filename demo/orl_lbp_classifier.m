function options = orl_lbp_classifier(Xtrain,dtrain,opcl)

clname = opcl.clname;

options = Bcl_exe(clname,Xtrain,dtrain,opcl);


