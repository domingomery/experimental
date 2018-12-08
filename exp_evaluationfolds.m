% options.method = 'CV';options.balanced = 1;options.folds=10;asr_makefolder(56,'age02',options);
function folds = exp_evaluationfolds(nimg,options)


n = length(nimg);


xk = zeros(sum(nimg),2);

t = 0;
for i=1:n
    ni = nimg(i);
    xk(t+1:t+ni,:) = [i*ones(ni,1) (1:ni)'];
    t = t+ni;
end


if ~isfield(options,'random')
    options.random = 1;
end

if ~isfield(options,'strat')
    options.strat = 1;
end

if options.random == 1
    j = randperm(t,t);
    xk = xk(j,:);
end


maxnimg = max(nimg);

pnimg = maxnimg./nimg-1;

tn = round((options.folds-1)/options.folds*maxnimg);



switch upper(options.method)
    case 'HO'
        s = options.ptrain;
        if options.strat == 1
            xk_train = [];
            xk_test  = [];
            for i=1:n
                ii = find(xk(:,1)==i);
                s1 = s;
                if s<1
                    ni = length(ii);
                    s1 = round(s*ni);
                end
                if and(options.balanced==1,pnimg(i)>0)
                    ss1 = repmat(randperm(s1,s1),[1 10]);
                    %                   tr  = randperm(s1,round(pnimg(i)*s1));
                    tr  = ss1(1:round(pnimg(i)*s1));
                    t1  = ii([1:s1 tr]);
                else
                    t1  = ii(1:s1);
                end
                t2 = ii(s1+1:ni);
                xk_train = [xk_train;xk(t1,:)];
                xk_test  = [xk_test ;xk(t2,:)];
                folds{1}.ix_train = xk_train;
                folds{1}.ix_test  = xk_test;
                
            end
        else
            s1 = s;
            if s<1
                s1 = round(s*t);
            end
            t1 = 1:s1;
            t2 = s1+1:t;
            xk_train = xk(t1,:);
            xk_test  = xk(t2,:);
            folds{1}.ix_train = xk_train;
            folds{1}.ix_test  = xk_test;
        end
        %        save([rootname '_' num2fixstr(1,ndigits)],'xk_train','xk_test');
    case 'CV'
        nf = options.folds;
        if options.strat == 1
            for k=1:nf
                xk_train = [];
                xk_test  = [];
                for i=1:n
                    ii        = find(xk(:,1)==i);
                    ni        = length(ii);
                    %                    p         = round(ni/nf);
                    %                    i1        = (k-1)*p+1;
                    p         = ni/nf;
                    i1        = round((k-1)*p+1);
                    if k<nf
                        i2    = round(i1+p-1);
                    else
                        i2    = ni;
                    end
                    t2        = ii(i1:i2);
                    t1        = ii;
                    t1(i1:i2) = [];
                    
                    if and(options.balanced==1,pnimg(i)>0)
                        tt1 = repmat(t1,[10,1]);
                        t1 = tt1(1:tn);
                    end
                    xk_train  = [xk_train;xk(t1,:)];
                    xk_test   = [xk_test ;xk(t2,:)];
                end
                folds{k}.ix_train = xk_train;
                folds{k}.ix_test  = xk_test;
                
            end
        else
            ii        = 1:t;
            ni        = t;
            p         = round(ni/nf);
            for k=1:nf
                i1        = (k-1)*p+1;
                if k<nf
                    i2 = i1+p-1;
                else
                    i2 = ni;
                end
                t2        = ii(i1:i2);
                t1        = ii;
                t1(i1:i2) = [];
                xk_train  = xk(t1,:);
                xk_test   = xk(t2,:);
                folds{k}.ix_train = xk_train;
                folds{k}.ix_test  = xk_test;
            end
        end
end




