function W=Dirichletverkefni(a,b,c,d,p,q,f,gamma,P,Q,R,U,h)
%Author: Andri Freyr Thorgeirsson, Erna Gudrun Thorsteinsdottir og 
%        Rikhardur Thor Rognvaldsson

% Breytur

% Setja upp reikninetid
M=(b-a)/h+1;               % Fjoldi hnitpunkta i x att
N=(d-c)/h+1;            % Fjoldi hnitpunkta i y att
% Skilgreinum staerd fylkis og haegri handar
A=zeros(M*N,M*N);       % Fylkid okkar er jafn stort og fjoldi punkta
RHS=zeros(M*N,1);       % Haegri hlid hefur somu staerd og fylkid en er vigur
    
%Setjum gildi i fylki og haegri hlid
for n=1:N
    for m=1:M
        
   % Vid kjosum ad rada T_m,n thar sem fyrst er n=1 og m haekkar fra 1 til M, 
   % Thvi naest haekkum vid n i 2 og haekkum m fra 1 til M, haekkum tha n i 3 og 
   % haekkum m fra 1 til M og svo framvegis thar til m is jafnt M
        
        s=m+M*(n-1);               % Numer linu fylkis sem samsvarar m,n
        s_m_plus1=m+1+M*(n-1);     % Numer linu fylkis sem samsvarar m+1,n
        s_m_minus1=m-1+M*(n-1);    % Numer linu fylkis sem samsvarar m-1,n
        s_n_plus1=m+M*(n+1-1);     % Numer linu fylkis sem samsvarar m,n+1
        s_n_minus1=m+M*(n-1-1);    % Numer linu fylkis sem samsvarar m,n-1
        
        % Jağarskilyrği - u = gamma
        % Skilyrdi: (n==1) -> Viljum skoda nedstu linuna kassans
        % Skilyrdi: (n==N) -> Viljum skoda efstu linuna kassans
        % Skilyrdi: (m==1) -> Viljum skoda vinstri hlid kassans
        % Skilyrdi: (m==M) -> Viljum skoda haegri hlid kassans
        if  (M==1) || (M==m) || (N==1) || (N==n)
            A(s,s) = 1;
            RHS(s) = gamma;
        end
        
        % Innri hnutpunktar kassans - jafna 22.3
        % Skilyrdi: (n>1)  -> Viljum ekki skoda nedstu linuna
        % Skilyrdi: (m>n) -> Viljum lenda haegra meginn vid vinstri
        %                    hlidarlinu thrihyrningsins
        % Skilyrdi: (m<M-n+1) -> Viljum lenda vinstra meginn vid haegri
        %                        hlidarlinu thrihyrningsins
        % Skilyrdi: (n<N) -> Viljum ekki lenda i topppunktinum.
        if (n>1) && (m>1) && (m<M) && (n<N)
            A(s,s) = 
            A(s,s_m_plus1) = 
            A(s,s_m_minus1) = 
            A(s,s_n_plus1) = 
            A(s,s_n_minus1) = 
            RHS(s) =  
        end
        
        % Vinstri hlid thrihyrnings - Varmaburdur og varmaflaedi
        % Skilyrdi: (n>1)  -> Viljum ekki skoda nedstu linuna
        % Skilyrdi: (n==m) -> Viljum lenda a vinstri hlidarlinu thrihyrnings
        % Skilyrdi: (n==median(1:N)) -> Viljum lenda i punktinum thar sem
        %                               varmaburdur og varmaflaedi maetast
        if  (n>1) && (n==m) && (n==median(1:N))
    
        end
         
        % Vinstri hlid thrihyrnings - Varmaflaedi
        % Skilyrdi: (n>1)  -> Viljum ekki skoda nedstu linuna
        % Skilyrdi: (n==m) -> Viljum lenda a vinstri hlidarlinu thrihyrnings
        % Skilyrdi: (n>median(1:N)) -> Viljum lenda fyrir ofan varmaburdinn
        if  (n>1) && (n==m) && (n>median(1:N)) && n < N
 
        end
        
        % Topp hornapunktur - Varmaflaedi og varmaburdur
        % Skilyrdi: (n==N) -> Viljum vera i topppunktunum
        % Skilyrdi: (m==median(1:M)) -> Viljum lenda i midpunkti x as
        if  (n==N) && (m==median(1:M))
 
        end
        
        % Haegri hlid thrihyrnings - Varmaburdur
        % Skilyrdi: (n>1)  -> Viljum ekki skoda nedstu linuna
        % Skilyrdi: (m==M-n+1) -> Viljum lenda a haegri hlidarlinu thrihyrnings
        % Skilyrdi: (n~=N) -> Viljum ekki lenda i topppunktinum.
        if (n>1) && (m==M-n+1) && n~=N

        end
        
        % Botn thrihyrnings - T1 = fasti
        % Skilyrdi: (n==1) -> Viljum bara skoda botnlinuna
        if n==1

        end
        

        
        % Ytri hnutapunktar thrihyrnings - thurfum ad setja inn til ad haegt
        %                                 se ad reikna ut fylkid okkar!
        % Skilyrdi: (n>1) -> Viljum ekki skoda nedstu linuna 
        % Skilyrdi: (m<n) -> Viljum lenda vinstra meginn vid vinstri
        %                    hlidarlinu thrihyrningsins
        % eda
        % Skilyrdi: (n>1) -> Viljum ekki skoda nedstu linuna 
        % Skilyrdi: (m>M-n+1) -> Viljum lenda haegra meginn vid haegri
        %                        hlidarlinu thrihyrningsins
        if ((n>1) && (m<n)) || ((n>1) && (m>M-n+1)) 

        end
    end 
end

%Finnum lausn

T_list=A\RHS;   % Thetta er vigur med hitastigum rodudum eins og vid til- 
                % greindum ad ofan




