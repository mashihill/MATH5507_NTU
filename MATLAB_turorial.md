# MATH5507: Hands-on MATLAB tutorial

## Outline

*   Why MATLAB?
*   MATLAB interface.
*   Hands-on exercise: Pricing European option.
*   Programming part of HW3.

## Why Programming?

*   Why?
<ul style="list-style: none;"><li>
</li></ul style="list-style: none;">

## Why MATLAB?

*   <u>MATrix LABoratory</u>
*   Alternative: GNU Octave

## MATLAB interface

*   Command window

    >> 1
    >> 1+2*3
    >> 5^9
    >> (12-5)/3
    >> sin(5)
    >> cos(pi)
    >> sin(cos(log(10)))
    try it!
    >> log(e)

_<u>What is the error message?</u>_

*   >> clc

*   Workspace - variables

*   >> x = 3
*   >> y = 4
*   >> z = (x^2+y^2)^0.5
*   >> x = x + 1
*   >> x 
*   >> y = y + x
**   >> clear

*   Current folder

*   m-file (later)

## From command to script

*   Pricing European call option

*   Black-Scholes formula:
*   ![](https://hackpad-attachments.s3.amazonaws.com/hackpad.com_xIBVpo7psFn_p.397027_1445087603330_latexit-drag.png)
*   ![](https://hackpad-attachments.s3.amazonaws.com/hackpad.com_xIBVpo7psFn_p.397027_1445087617564_latexit-drag.png)
*   ![](https://hackpad-attachments.s3.amazonaws.com/hackpad.com_xIBVpo7psFn_p.397027_1445087635463_latexit-drag.png)
*   ![](https://hackpad-attachments.s3.amazonaws.com/hackpad.com_xIBVpo7psFn_p.397027_1445088227039_latexit-drag.png)
*   Suppose: ` x=100, K=90, r=0.05, sigma=0.2, T-t = 20 `
*   try-it!  

*   >> x = 100
*   >> K = 90
*   >> r = 0.05
*   >> sigma = 0.2
*   >> tau = 20
*   >> d1 = (log(x/K) + (r + 0.5*sigma^2)*(tau))/(sigma*sqrt(tau))
*   >> d2 = d1 - sigma*sqrt(tau)
*   >> N1 = normcdf(d1)
*   >> N2 = normcdf(d2)
*   >> C = x*N1 - K*exp(-r*(tau))*N2

*   How about `K = 100` ?

*   >> K = 100
*   >> d1 = (log(x/K) + (r + 0.5*sigma^2)*(tau))/(sigma*sqrt(tau))
*   >> d2 = d1 - sigma*sqrt(tau)
*   >> N1 = normcdf(d1)
*   >> N2 = normcdf(d2)
*   >> C = x*N1 - K*exp(-r*(tau))*N2

*   How about `K = 110, K=115, K=120`... ?

*   ....

*   Let's write a script!

*   % Program for Pricing European call option
*   % Input arguments: x = stock price at time t,
*   %                  K = Exercise value,
*   %                  r = interest rate,
*   %                  sigma = volatility,
*   %                  tau = T-t       
*   x = 100
*   K = 90
*   r = 0.05
*   sigma = 0.2
*   tau = 20
*   d1 = (log(x/K) + (r + 0.5*sigma^2)*(tau))/(sigma*sqrt(tau))
*   d2 = d1 - sigma*sqrt(tau)
*   N1 = normcdf(d1)
*   N2 = normcdf(d2)
*   C = x*N1-K*exp(-r*(tau))*N2

*   >> callPrice

*   Semicolon -** mute** the output

*   % Program for Pricing European call option
*   % Input arguments: x = stock price at time t,
*   %                  K = Exercise value,
*   %                  r = interest rate,
*   %                  sigma = volatility,
*   %                  tau = T-t 
*   x = 100;
*   K = 90;
*   r = 0.05;
*   sigma = 0.2;
*   tau = 20;
*   d1 = (log(x/K) + (r + 0.5*sigma^2)*(tau))/(sigma*sqrt(tau));
*   d2 = d1 - sigma*sqrt(tau);
*   N1 = normcdf(d1);
*   N2 = normcdf(d2);
*   C = x*N1 - K*exp(-r*(tau))*N2
**   >> callPrice

*   Exercise: Output the Put option price (Hint: by Put-Call parity)

*   ![](https://hackpad-attachments.s3.amazonaws.com/hackpad.com_xIBVpo7psFn_p.397027_1445087671771_latexit-drag.png)
*

*   Q: Can we define a "function" like sin(x) to calculate the call price, 
<ul style="list-style: none;"><li>i.e. for example: `euCall(100, 90)` , so that it can be "called" by others (people or another function)? </li>
<li>A: Yes!</li>
<li>
</li></ul style="list-style: none;">

## From Script to Function

*   Here's what we want:

*   >> euCall(100, 90)

*   function [ output ] = euCall( x, K )
*       % This is a function to calculate call price
*       r = 0.05;
*       sigma = 0.2;
*       tau = 20;
*       d1 = (log(x/K) + (r + 0.5*sigma^2)*(tau))/(sigma*sqrt(tau));
*       d2 = d1 - sigma*sqrt(tau);
*       N1 = normcdf(d1);
*       N2 = normcdf(d2);
*       output = x*N1 - K*exp(-r*(tau))*N2;
*   end

*    

*   >> euCall(100, 80)
*   >> euCall(100, 85)
*   >> euCall(100, 90)
*   >> .....

*   Try it: write a function to output the put option price, 

*   i.e. `euPut(x, K)` (Use euCall() !)
*

*   I want to know the relation between K and price ...

*   >> euCall(100, 95)
*   >> euCall(100, 100)
*   >> euCall(100, 110)
*   .....

*   (1) Is there a better way? Yes.
*   (2) How to visualize it? Let's see.

## Control Flow 

*   For loop

*   % This is a script to calculate option price for K from 90 to 120  
*   C = zeros(101, 1);
*   P = zeros(101, 1);
*   for i=1:101
*       C(i) = euCall(100, 50 + (i-1));
*       P(i) = euPut(100, 50 + (i-1));
*   end
**   >> C
*   >> P

## Plot

*   >> x = 50:150
*   >> plot(x, C)
*   >> hold on
*   >> plot(x, P)

*   >> clf

## More about matrix

*   generate matrix

*   >> A = [1 2 3; 4 5 6]

*   or

*   >> A = [1, 2, 3; 4, 5, 6]

*   matrix operation

*   >> A(2,3) = 100
*   >> A = zeros(10, 2)
*   >> A = eye(5)
*   >> A = rand(10, 2)
**   >> A = [3,4,5; 6,7,8]; B = [1,2,3; 1,2,3];
*   >> A*B % ??
*   >> A.*B
*   >> A./B
*   >> A.^B
**   >> AT = A'

*   det(A), inv(A), eig(A) .... (too much)
*
<undefined><li>**The use of ":" **</li></undefined>

*   >> 1:30
*   >> 1:2:30
*   >> A = rand(4, 8)
*   >> A(2, :)  % equals A(2, [1,2,3,4,5,6,7,8])
*   >> A(3:end, 3:6)

*   Write function for matrix input 
<ul class="code"><li>function [ output_args ] = euCall( x, K )</li>
<li>% This is a function to calculate call price</li>
<li>    r = 0.05;</li>
<li>    sigma = 0.2;</li>
<li>    tau = 20;</li>
<li>    X = x';</li>
<li>    KK = K;</li>
<li>    if size(K,2)>1</li>
<li>        for i = 1:size(K,2)-1</li>
<li>            X = [X x'];</li>
<li>        end</li>
<li>    end</li>
<li>    if size(x,2)>1</li>
<li>        for j = 1:size(x,2)-1</li>
<li>            KK = [KK ; K];</li>
<li>        end</li>
<li>    end</li>
<li>
</li>
<li>    d1 = (log(X./KK) + (r + 0.5*sigma^2)*(tau))/(sigma*sqrt(tau));</li>
<li>    d2 = d1 - sigma*sqrt(tau);</li>
<li>    N1 = normcdf(d1);</li>
<li>    N2 = normcdf(d2);</li>
<li>    output_args = X.*N1-KK.*exp(-r*(tau)).*N2;</li>
<li>
</li>
<li>end</li>
<li>
</li></ul class="code">

## HW3

*   >> M = csvread('table.csv')
*   >> M = csvread('table.csv', 1, 1)
*   >> W = M(:, 6)
*   >> x = log(W(2:end)./W(1:end-1))
*   >> histogram(x)
*   >> kstest(x)
***   function [mean variance] = BM(n,t)
*       for i=1:n
*           x=[0:1/t:1];
*           dW=randn(1,t).*sqrt(1/t);
*           dW1=[0 dW];
*           W=cumsum(dW1,2);
*           if i==1
*               plot(x,W);
*               hold on
*           else
*               plot(x,W);
*           end
*           com(i)=W(251);
*       end
*       hold off
*       mean=sum(com)/n;
*       variance=var(com); 
*   end

## Resources

[](http://mirlab.org/jang/books/matlabProgramming4beginner/)http://mirlab.org/jang/books/matlabProgramming4beginner/

[](http://mirlab.org/jang/books/matlabProgramming4guru/)http://mirlab.org/jang/books/matlabProgramming4guru/

[](http://bime-matlab.blogspot.tw/)http://bime-matlab.blogspot.tw/

ptt MATLAB版

## Question

