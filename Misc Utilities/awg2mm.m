%[text] Given the size of a wire in AWG, the function returns the diameter of the wire in millimeters.
%[text] The formula for converting AWG to a diameter in inches is: $\\theta\_{\\mathrm{in}} =0\\ldotp 005\\times {92}^{\\frac{36-\\mathrm{awg}}{39}}${"editStyle":"visual"}. Then the simple conversion to millimeters is done. To simplify we can simply combine the steps $\\frac{25\\ldotp 4}{0\\ldotp 005}=\\frac{127}{1000}${"editStyle":"visual"} and do $0\\ldotp 1270\\times {92}^{\\frac{36-\\mathrm{AWG}}{39}}${"editStyle":"visual"}which is still ugly as sin but that's AWG for you baby. Also, yes I am notating this so I don't forget where the wonky numbers came from...
function mm = awg2mm(awg)
    mm = 0.1270 .* (92 .^ ((36 - awg) ./ 39));
end

%[appendix]{"version":"1.0"}
%---
