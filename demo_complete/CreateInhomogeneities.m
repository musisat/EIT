function CreateInhomogeneities(Node,Element)
% CREATEINHOMOGENEITIES will create a domain to replicate the cross section
% of lungs and heart. Maybe make this a function to be able to select which
% domain we want to test. This script will be useful for performing
% electrode tolerance testing.

% Assign resistivity values, measured in ohm-meters.
% Bone: 150
% Fat: 25
% Muscle: 5
% Blood: 1.5
% Plasma/interstitial fluid: 0.65
% The above values come from the upper arm.
% "Lung resistivity is about five-fold higher than other organs in the
% thorax."

% For now, choose background resistivity to be 8 ohm*m. Heart is full of
% blood and can be 1.5 ohm*m. Lungs can be 8*5=40 ohm*m.
baseR = 8;
lungR = 5*baseR;
heartR = 1.5;

lungInd1 = ChooseCircleXY(Node,Element,[-5,3.8],[-5,9]);
lungInd2 = ChooseCircleXY(Node,Element,[5,3.8],[5,9]);
heartInd = ChooseCircleXY(Node,Element,[0,-4],[0,-6]);

