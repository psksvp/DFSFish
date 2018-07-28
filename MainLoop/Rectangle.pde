/*
COMP115 A3
My Fish finds its path to target
by pongsak.suvanpong@mq.edu.au 

Copyright (c) 2014, Pongsak Suvanpong
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of 
conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation and/or other 
materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may 
be used to endorse or promote products derived from this software without specific 
prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS 
OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY 
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
public class Rectangle
{
    private Coordinate topleft = new Coordinate();
    private Size size = new Size();
    
    public Rectangle()
    {
        this.set(0, 0, 0, 0);
    }
    
    public Rectangle(float X, float Y, float W, float H)
    {
        this.set(X, Y, W, H);
    }
    
    public Rectangle(Coordinate topLeft, Size size)
    {
        this.set(topLeft, size);
    }
    
    public void set(Coordinate topLeft, Size size)
    {
        this.topLeft().set(topLeft.X(), topLeft.Y());
        this.size.set(size.width(), size.height());
    }
    
    public void set(float X, float Y, float W, float H)
    {
        this.topleft.set(X, Y);
        this.size.set(W, H);
    }
    
    public Coordinate topLeft()
    {
        return this.topleft;
    }
    
    public Size size()
    {
        return this.size;
    }
    
    Coordinate center()
    {
        float cx = this.topleft.X() + this.size.width() / 2.0f;
        float cy = this.topleft.Y() + this.size.height() / 2.0f;
        
        return new Coordinate(cx, cy);
    }
    
    boolean contain(Coordinate p)
    {
        if(p.X() >= this.topLeft().X() && p.Y() >= this.topLeft().Y() &&
           p.X() <= this.topLeft().X() + this.size().width() && p.Y() <= this.topLeft().Y() + this.size().height())
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
