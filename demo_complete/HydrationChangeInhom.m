
load meshdata 

NNode1=max(size(Node1));                      %The number of nodes
NElement1=max(size(Element1));                %The number of element
% The mesh for the inhomogeneities:
NNode2=max(size(Node2));                      %The number of nodes
NElement2=max(size(Element2));                %The number of elements

g1=reshape([Node1.Coordinate],2,NNode1)';
H1=reshape([Element1.Topology],3,NElement1)';
g2=reshape([Node2.Coordinate],2,NNode2)';
H2=reshape([Element2.Topology],3,NElement2)';


% Initial inhomogeneous domain:
sigma = CreateInhomogeneities(Node2,Element2,7);
figure(1)
clf,Plotinvsol(1./sigma,g2,H2);colorbar,title('Resistivity distribution','FontSize',12),set(gca,'FontSize',12);drawnow
figure(2)

L=16;					      % The number of electrodes.
z=0.005*ones(L,1);			  % Contact impedances.
% We want the rms current to be 800uA.
rms = 800e-6;
[~,T]=Current(L,NNode2,'tri',rms);	
[Agrad,Kb,M,S,C]=FemMatrix(Node2,Element2,z);
A=UpdateFemMatrix(Agrad,Kb,M,S,sigma);  % The system matrix.
[U1,~,~]=ForwardSolution(NNode2,NElement2,A,C,T,[],'real'); % Simulated data.
Uel1=U1.Electrode(:);


% Final inhomogeneous domain:
sigma = CreateInhomogeneities(Node2,Element2,10);       % Make a conductivity vector.

[II1,T]=Current(L,NNode2,'tri',rms);	
[Agrad,Kb,M,S,C]=FemMatrix(Node2,Element2,z);
A=UpdateFemMatrix(Agrad,Kb,M,S,sigma);  % The system matrix.
[U2,~,~]=ForwardSolution(NNode2,NElement2,A,C,T,[],'real'); % Simulated data.
Uel2=U2.Electrode(:);
figure(3)
clf,Plotinvsol(U2.Current,g2,H2); colorbar,title('Final potential distribution','FontSize',12),set(gca,'FontSize',12); drawnow;
figure(2)
clf,Plotinvsol(U1.Current,g2,H2);colorbar,title('Initial potential distribution','FontSize',12),set(gca,'FontSize',12); drawnow;
caxis([min(min(U2.Current)), max(max(U2.Current))]);
