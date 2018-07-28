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
import java.util.*;

class DFSController extends HeuristicController
{
    private int xStepSize;
    private int yStepSize; 
    private int nStepHorizontally;
    private int nStepVertically;
    private boolean[][] map; 
    private Rectangle world;
    ///////////////////////////////////////// 
    private GameObject currentSeeker;
    private GameObject[] currentBarriers;
    
    public DFSController(int xStepSize, int yStepSize)
    {
        this.xStepSize = xStepSize;
        this.yStepSize = yStepSize;
    }
    
    public List<Coordinate> calculatePath(GameObject seeker, Barrier[] barriersArray, Rectangle goal)
    {
        this.world = new Rectangle(0, 0, width + goal.size().width(), height + goal.size().height());
        this.nStepHorizontally = (width / this.xStepSize) + 2; 
        this.nStepVertically = (height / this.yStepSize);
        //println(this.nStepHorizontally + " " + this.nStepVertically);
        this.map = new boolean[this.nStepVertically][this.nStepHorizontally];
        
        for(int i = 0; i < this.nStepVertically; i++)
        {
            for(int j = 0; j < this.nStepHorizontally; j++)
            {
                this.map[i][j] = false;
            }
        }
        
        //seeker.setLocation(0, (int)(random(this.nStepVertically) * this.yStepSize));
        seeker.setLocation(0, this.nStepVertically / 2);
        
        this.currentSeeker = seeker;
        this.currentBarriers = barriersArray;
    
        LinkedList<Coordinate> path = new LinkedList<Coordinate>();
        if(true == findPath(seeker.location(), goal, path))
        {
            return path;
        }
        else
        {
            return null;
        }
    }
    
    private boolean findPath(Coordinate currentPosition, Rectangle goal, LinkedList<Coordinate> path)
    {
        path.add(currentPosition);
        if(true == goal.contain(currentPosition))
        {
            return true;
        }
        ArrayList<Coordinate> aviableMoves = avialableMovesFrom(currentPosition);
        for(Coordinate c : aviableMoves)
        {
            if(-1 == path.indexOf(c))
            {
                if(true == findPath(c, goal, path))
                {
                    return true;
                }
                markMap(c);    
            }
            
        }
        
        return false;
    }
    
    /*
    private boolean bfsFindPath(Coordinate currentPosition, Rectangle goal, LinkedList<Coordinate> path)
    {
        //Queue<Coordinate> Q = new LinkedList<Coordinate>();
        Stack<Coordinate> s = new Stack<Coordinate>();
        s.push(currentPosition);
        path.add(currentPosition);
        while(false == s.isEmpty())
        {
            Coordinate t = s.pop(); //Q.remove();
            if(true == goal.contain(t))
            {
                 //print("+");
                return true;
            }
            ArrayList<Coordinate> aviableMoves = avialableMovesFrom(t);
            for(Coordinate u : aviableMoves)
            {
                if(-1 == path.indexOf(u))
                {
                    path.add(u);
                    s.push(u);
                    //print("*");
                }
            }
            //print(".");
        }
        // print("-");
        return false;
    } */
    
    private ArrayList<Coordinate> avialableMovesFrom(Coordinate currentPosition)
    {
        Coordinate north = new Coordinate(currentPosition.X(), currentPosition.Y() - this.yStepSize);
        Coordinate northEast = new Coordinate(currentPosition.X() + this.xStepSize , currentPosition.Y() - this.yStepSize);
        Coordinate east = new Coordinate(currentPosition.X() + this.xStepSize , currentPosition.Y());
        Coordinate southEast = new Coordinate(currentPosition.X() + this.xStepSize , currentPosition.Y() + this.yStepSize);
        Coordinate south = new Coordinate(currentPosition.X() , currentPosition.Y() + this.yStepSize);
        
        ArrayList<Coordinate> moves = new ArrayList<Coordinate>(5);
        
        
        if(true == canMoveTo( east))
        {
            moves.add(east);
        }
        if(true == canMoveTo(south))
        {
            moves.add(south);
        }
        
        if(true == canMoveTo(southEast))
        {
            moves.add(southEast);
        }  
        
        if(true == canMoveTo(northEast))
        {
            moves.add(northEast);
        } 
        
        return moves;
    }
    
    private boolean canMoveTo(Coordinate toPosition)
    {
        if(toPosition.X() < 0 || toPosition.Y() < 0 || 
           toPosition.X() > this.world.size().width() || 
           toPosition.Y() > this.world.size().height() - this.currentSeeker.bounding().size().height() * 2)
        {
            return false;
        }

        if(false == isMapMarked(toPosition))
        {
            Coordinate savedLocationOfSeeker = this.currentSeeker.location();
            this.currentSeeker.setLocation(toPosition);
            boolean collide = hasGameObjectCollidedWithGameObjects(this.currentSeeker, this.currentBarriers);
            this.currentSeeker.setLocation(savedLocationOfSeeker);
            if(true == collide)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            return false;
        }
    }
    
    private void markMap(Coordinate position)
    {
        int mapIdRow = (int)(position.Y() / this.yStepSize);
        int mapIdCol = (int)(position.X() / this.xStepSize);
        //println(mapIdRow + "," + mapIdCol);
        if(mapIdRow >= this.nStepVertically || mapIdCol >= this.nStepHorizontally)
        {
            //print("-");
        }
        else
        {
            this.map[mapIdRow][mapIdCol] = true;
        }
    }
    
    private boolean isMapMarked(Coordinate position)
    {
        int mapIdRow = (int)(position.Y() / this.yStepSize);
        int mapIdCol = (int)(position.X() / this.xStepSize);
        
        if(mapIdRow >= this.nStepVertically || mapIdCol >= this.nStepHorizontally)
        {
            return false;
        }
        else
        {
            return this.map[mapIdRow][mapIdCol];
        }
    }
    
}
