function ds = exp_testpar(tsname,Xtest,options)

n = size(Xtest,1);

q = n/options.m;

ds = zeros(q,1);



myPool = gcp;
if not(myPool.Connected)
    myPool = parpool();
end
C     = myPool.NumWorkers; % #cores
nj    =n/C;
if fix(nj)~=nj
    error('Number of samples is not divisible by the number of cores');
end

spmd
    j = labindex;
    fprintf('Cluster %d...\n',j);
    jj = indices(j,n/C);
    kk = indices(j,q/C);
    ops = options;
    ops.ix_test = options.ix_test(kk,:);
    dsj = feval(tsname,Xtest(jj,:),ops);
    % dsj = j*ones(q/C,1);
end
for c=1:C
    ds(kk{c},:) = dsj{c};
     %dsj{c}+1
     %disp('*')
     %jj{c}
end
delete(gcp);


