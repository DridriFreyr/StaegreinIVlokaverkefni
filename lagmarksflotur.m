function [Wn,A,RHS]=lagmarksflotur(a,b,c,d,p,q,f,gamma,P,Q,R,U,h,W0)
%Author: Andri Freyr Thorgeirsson, Erna Gudrun Thorsteinsdottir og
%        Rikhardur Thor Rognvaldsson

% Breytur

% Setja upp reikninetid
M=(b-a)/h+1;               % Fjoldi hnitpunkta i x att
N=(d-c)/h+1;            % Fjoldi hnitpunkta i y att
% Skilgreinum staerd fylkis og haegri handar
A=zeros(M*N,M*N);       % Fylkid okkar er jafn stort og fjoldi punkta
RHS=zeros(M*N,1);       % Haegri hlid hefur somu staerd og fylkid en er vigur
ki = 1;                 % Dummy breyta fyrir visun � Rs
kj = 1;                 % Dummy breyta fyrir v�sun � Qs
%Setjum gildi i fylki og haegri hlid
x_vigur = linspace(a,b,M);
y_vigur = linspace(c,d,N);
r_hnit=NaN;
p_hnit=NaN;
if ~isempty(R)
    r_hnit = zeros(length(R(:,1)),length(R(1,:)));
    for i = 1:length(R(:,1))
        r_hnit(i,1) = min(find(x_vigur>=R(i,1)));
        r_hnit(i,2) = min(find(y_vigur>=R(i,2)));
    end
end
r_hnit = fliplr(sortrows(r_hnit));
if ~isempty(P)
    
    p_hnit = zeros(length(P(1,:)),length(P(:,1)));
    for j = 1:length(R(:,1))
        p_hnit(j,1) = min(find(x_vigur>=P(j,1)));
        p_hnit(j,2) = min(find(y_vigur>=P(j,2)));
    end
end



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
        
        s_n_minus1_m_minus1 =  m+M*(n-1-1)-1;    % Numer linu fylkis sem samsvarar m-1,n-1
        s_n_minus1_m_plus1 =  m+M*(n-1-1)+1;     % Numer linu fylkis sem samsvarar m+1,n-1
        s_n_plus1_m_minus1 = m+M*(n+1-1)-1;      % Numer linu fylkis sem samsvarar m-1,n+1
        s_n_plus1_m_plus1 = m+M*(n+1-1)+1;     % Numer linu fylkis sem samsvarar m+1,n+1n
        
        x = a+(m-1)*h;
        y = c+(n-1)*h;
        x_half = a+(m-1)*(h/2);
        y_half = c+(n-1)*(h/2);
        
        % Vi�b�t 2 - fast gildi � �kve�num punkti
        
        % Ja�arskilyr�i - u = gamma
        % Skilyrdi: (n==1) -> Viljum skoda nedstu linuna kassans
        % Skilyrdi: (n==N) -> Viljum skoda efstu linuna kassans
        % Skilyrdi: (m==1) -> Viljum skoda vinstri hlid kassans
        % Skilyrdi: (m==M) -> Viljum skoda haegri hlid kassans
        if  (m==1) || (M==m) || (n==1) || (N==n)
            A(s,s) = 1;
            RHS(s) = W0(s);
%             fprintf('Jadarpunktur n=%.0f , m = %.0f\n',n,m)
        end
        
        % Innri hnutpunktar kassans - jafna 22.3
        % Skilyrdi: (n>1)  -> Viljum ekki skoda nedstu linuna
        % Skilyrdi: (m>n) -> Viljum lenda haegra meginn vid vinstri
        %                    hlidarlinu thrihyrningsins
        % Skilyrdi: (m<M-n+1) -> Viljum lenda vinstra meginn vid haegri
        %                        hlidarlinu thrihyrningsins
        % Skilyrdi: (n<N) -> Viljum ekki lenda i topppunktinum.
        if (n>1) && (m>1) && (m<M) && (n<N)
            % Reiknum n�lgunina � afleidunum
            p_m_minus1 = 1/sqrt(1+abs((W0(s)-W0(s_m_minus1))/(h)+(W0(s_n_plus1_m_minus1)+W0(s_n_plus1)-W0(s_n_minus1_m_minus1)-W0(s_m_plus1))/(4*h))^2);
            p_n_plus1 = 1/sqrt(1+abs((W0(s)-W0(s_n_plus1))/(h)+(W0(s_n_plus1_m_minus1)+W0(s_m_minus1)-W0(s_n_plus1_m_plus1)-W0(s_m_plus1))/(4*h))^2);
            p_n_minus1 = 1/sqrt(1+abs((W0(s_n_minus1)-W0(s))/(h)+(W0(s_n_minus1_m_minus1)+W0(s_m_minus1)-W0(s_n_minus1_m_plus1)-W0(s_m_plus1))/(4*h))^2);
            p_m_plus1 = 1/sqrt(1+abs((W0(s_m_plus1)-W0(s))/(h)+(W0(s_n_plus1)+W0(s_n_plus1_m_plus1)-W0(s_n_minus1)-W0(s_n_minus1_m_plus1))/(4*h))^2);
            
            
            A(s,s) = ((p_m_plus1+p_m_minus1+p_n_plus1+p_n_minus1)/h^2)+q(x,y);
            A(s,s_m_plus1) = -p_m_plus1/h^2;
            A(s,s_m_minus1) = -p_m_minus1/h^2;
            A(s,s_n_plus1) = -p_n_plus1/h^2;
            A(s,s_n_minus1) = -p_n_minus1/h^2;
            RHS(s) = 0;
%             fprintf('Innripunktur n=%.0f , m = %.0f\n',n,m)
            if ~isnan(p_hnit)
                if m == p_hnit(kj,1) && p_hnit(kj,2) == n && kj<=length(P(:,1))
                    RHS(s) = 0;
                    kj=kj+1;
%                     fprintf('S�rst��upunktur - Punktuppspretta x=%.2f , y = %.2f , n=%.0f , m = %.0f\n',x,y,n,m)
                end
            end
        end
        if  ki<=length(r_hnit(:,1))
            if m == r_hnit(ki,1) && r_hnit(ki,2) == n
                A(s,:) = 0;
                A(s,s) = 1;
                RHS(s) = W0(s);
                ki = ki+1;
%                 fprintf('S�rst��upunktur - FAST GILDI x=%.2f , y = %.2f , n=%.2f , m = %.0f\n',x,y,n,m)
            end
        end
    end
end
%Finnum lausn
A_sparse=sparse(A);
Wn_list=A_sparse\RHS;   % Thetta er vigur med hitastigum rodudum eins og vid til-
% greindum ad ofan
Wn_grid=zeros(N,M);
for n=1:N
    for m=1:M
        s=m+M*(n-1);   % Numer linu fylkis sem samsvarar m,n
        Wn_grid(n,m) = Wn_list(s); % Setjum inn gildi sem samsvarar
        % gildi fyrir thrihyrninginn okkar.
    end
end
Wn=Wn_grid;






