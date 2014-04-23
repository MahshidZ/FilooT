  
  class MatrixView {
  	int _width, _height;
  	int[] _cellPos;  
  	int _cellWidth;
  	int _columnLabelWidth;
        int _columnLabelHeight;  
  	boolean y_reachtoMax=false;
  	ArrayList _GroupData;
  	int ColumnOffset;
  
  	MatrixView(){
  		_cellWidth=GeneralcellWidth;
  		_columnLabelWidth=_cellWidth;
  		_columnLabelHeight=30-5;
  
  		_cellPos = new int[2];

  		_cellPos[1]=145;
 
  		ColumnOffset=10;
  		_width=((NUM_CHARACTERS+1)*_cellWidth) + (NUM_CHARACTERS)*ColumnOffset;
  		_height=505;   

  		_GroupData= new ArrayList();
  _cellPos[0]= (_columnLabelWidth*(NUM_CHARACTERS+1))+(NUM_CHARACTERS)*ColumnOffset;
  	}
  
  	void render(){
  		strokeCap(SQUARE);
  		noSmooth();
  		stroke( frameColor);
  		strokeWeight( frameWidth);
  		noFill();
  
  		rect(0,_columnLabelHeight/2+2,  getMaxWidth()  ,getMaxHeight()-_columnLabelHeight/2-2 );  
  		strokeCap(SQUARE);
  		noSmooth();
  
                      stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  noFill();
                rect( 15,_columnLabelHeight/2+30,  30 ,SAVE_LOAD_VIEW_BUTTON_HEIGHT );  
                    stroke( 0 );
  		 fill( BORDER_COLOR*2 );

                  			textAlign( LEFT, BOTTOM );
  			text("add",
  					_matrix_view_origin[0]+ 15+4, 
  					_matrix_view_origin[1]+ _columnLabelHeight/2+30+14
  					);
                
               
 
  		//
  		// render the labels
  		//
  strokeWeight(  SCROLL_LINE_WEIGHT );
  		for(int i=0;i<NUM_CHARACTERS;i++){ 
  			String value=(database.CharactristicsHeader).getHeader(i);  
  			stroke( SCROLL_BACKGROUND_COLOR );    
  			fill(130);
  			rect(_cellPos[0] -(i+1)* _columnLabelWidth-i*ColumnOffset,
  					_cellPos[1]-_columnLabelHeight,
  					_columnLabelWidth,
  					_columnLabelHeight);  
  			fill( BACKGROUND_COLOR);
  			textFont(_pixel_font_8);
  			textFont(ss);
  			textAlign( LEFT, BOTTOM );
  			text(value,
  					_matrix_view_origin[0]+ _cellPos[0] -(i+1)* _columnLabelWidth+2 - i*ColumnOffset, 
  					_matrix_view_origin[1]+ _columnLabelHeight/2+5+_cellPos[1]-_columnLabelHeight
  					);
  // border of the summary views 
  
                      rect(_cellPos[0] -(i+1)* _columnLabelWidth-i*ColumnOffset,
  					 getMaxHeight() +2,
  					_columnLabelWidth,
  					_columnLabelHeight);  
  
  		}

  
  		//
  		// render the "new" column label
  		//
  
  		stroke( SCROLL_BACKGROUND_COLOR );    
  
  		fill(130);
  		rect(_cellPos[0] -((NUM_CHARACTERS+1)* _columnLabelWidth)- ((NUM_CHARACTERS)*ColumnOffset),
  				_cellPos[1]-_columnLabelHeight,
  				_columnLabelWidth,
  				_columnLabelHeight);  
  		fill( BACKGROUND_COLOR);
  		textFont(_pixel_font_8b);
  		textFont( ss);
  		textAlign( LEFT, BOTTOM );
  
  		text("New",
  				_matrix_view_origin[0]+ _cellPos[0] -(NUM_CHARACTERS+1)* _columnLabelWidth+5 - (NUM_CHARACTERS)*ColumnOffset, 
  				_matrix_view_origin[1]+ _columnLabelHeight/2+5+_cellPos[1]-_columnLabelHeight
  				);   
  
  		//
  		// render the "New" boarder
  		//
  		noFill();
  		stroke( BORDER_COLOR );
  		strokeWeight( BORDER_WEIGHT );
  		rectMode( CORNER );
  		rect( _cellPos[0] -((NUM_CHARACTERS+1)* _columnLabelWidth)- ((NUM_CHARACTERS)*ColumnOffset) , _cellPos[1], _columnLabelWidth ,
  NumberOfVisualizedStrains*cellHeight
  );      
  		//
  		// render each charactristics column boarder
  		//  
  
  		for(int i=0;i<NUM_CHARACTERS;i++)  		{ 
  			int num=(  (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels )  .size());
  
  			Collections.sort(   (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels ), new EachCharacterComparator());
  
  			int sketched=-2;
  
  // This is the header in color
  			for(int k=0;k<num;k++){  
  				fill(256);
  				rect( -((i+1)* _columnLabelWidth)+_cellPos[0]-i*ColumnOffset ,
  						_cellPos[1]+(sketched)*_columnLabelHeight -1,
  						_columnLabelWidth,
  						_columnLabelHeight);   
  
  				fill(i*50,i*10,i*20,(k+1)*70);
  				if(i<1)
  					fill(COLORMAP_6[i],(k+1)*70);
  				else if(i<2)
  					fill(COLORMAP_4[i+5],(k+1)*70);
  				else if(i<3)
  					fill(COLORMAP_5[i],(k+1)*70);
  				else
  					fill(COLORMAP_2[i*2],(k+1)*70);
  				rect( -((i+1)* _columnLabelWidth)+_cellPos[0] + k* _columnLabelWidth/num -i*ColumnOffset, 
                               _cellPos[1]+(sketched)*_columnLabelHeight -1, _columnLabelWidth/num, _columnLabelHeight);  
  			}
  
  
  
  			sketched=0; 
  			int numberOfRows=( ((Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();
  
  
  			for(int j=y_start;((sketched<height_WindowSize)&&j<(numberOfRows));j++){   
  
  				int seqIndex=i;
  				String valueSeqLabel=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getHeader(j);
  				//seqIndex=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getIndex(valueSeqLabel);
  
  				seqIndex=database.getIndex(valueSeqLabel);
  				//  System.out.println(seqIndex + " " + j);  // Because the data is sorted too not just the headrers. It is because of the speed.
  
  				String valueChar=((Strain)((database._data).get(seqIndex))).getCharactristicsAt(i);  
  
  
  				int level=( (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels ).indexOf(valueChar));
  
  				fill(256);
  				rect( -((i+1)* _cellWidth)+_cellPos[0]-i*ColumnOffset,
  						_cellPos[1]+(sketched)*cellHeight,
  						_cellWidth, 
  						cellHeight);   
  
  				fill(i*50,i*10,i*20,(level+1)*70);
  				if(i<1)
  					fill(COLORMAP_6[i],(level+1)*70);
  
  				else if(i<2)
  					fill(COLORMAP_4[i+5],(level+1)*70);
  
  				else if(i<3)
  					fill(COLORMAP_5[i],(level+1)*70);
  				else
  					fill(COLORMAP_2[i*2],(level+1)*70);
  				rect( -((i+1)* _cellWidth)+_cellPos[0] + level* _cellWidth/num - i*ColumnOffset, 
  						_cellPos[1]+(sketched)*cellHeight, 
  						_cellWidth/num, 
  						cellHeight);   
  
  				sketched++; 

  			} // j  
  		}//i

  		RenderButtons();
  
  
  
  
   //************* test *********
   
   int OvewW=_columnLabelWidth;
   int OvewH=_columnLabelHeight;
   float ghotr=OvewH/NUM_SEQUENCES;
 
  
    int VisiH=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();
    
    
   
        if(VisiH > 0 ){
 if((OvewH/VisiH) >  ghotr){
    ghotr=OvewH/VisiH;
 }
 else if((OvewH/VisiH) <1  )
 {
   ghotr=1;
   
 }
 
 
  }
    
    
    
    
  		for(int i=0;i<NUM_CHARACTERS;i++)  		{ 
  			int num=(  (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels )  .size());
  
  			//Collections.sort(   (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels ), new EachCharacterComparator());
  
//  
//   stroke( SCROLL_BACKGROUND_COLOR );    
//  			fill( BACKGROUND_COLOR);
//  
//  			for(int k=0;k<num;k++){  
//
//  				rect( -((i+1)* _columnLabelWidth)+_cellPos[0] + k* _columnLabelWidth/num -i*ColumnOffset, 
//                              getMaxHeight() +2+(sketched)*_columnLabelHeight -1,
//                              _columnLabelWidth/num,
//                              _columnLabelHeight);  
//  			}
//  
  
  
  			int sketched=0; 
  			int numberOfRows=( ((Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();
  
  			for(int j=0;(j<(numberOfRows));j++){   
  
  				int seqIndex=i;
  				String valueSeqLabel=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getHeader(j);
  
  				seqIndex=database.getIndex(valueSeqLabel);
  		
  				String valueChar=((Strain)((database._data).get(seqIndex))).getCharactristicsAt(i);  
  
  
  			int level=( (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels ).indexOf(valueChar));
  fill( SCROLL_BACKGROUND_COLOR/2 ); 
  stroke( SCROLL_BACKGROUND_COLOR );    
 		//_columnLabelHeight/NUM_SEQUENCES	
  strokeWeight(ghotr);
  stroke((( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getColor(j));
  if(((( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getColor(j)) == MOUSEOVER)
  strokeWeight(ghotr*5);
  
   line( -((i+1)* _cellWidth)+_cellPos[0]-i*ColumnOffset +  (OvewW/num)*level,
   getMaxHeight() +(sketched+1)*(ghotr) ,
   -((i+1)* _cellWidth)+_cellPos[0]-i*ColumnOffset +  (OvewW/num) +  (OvewW/num)*level,
    getMaxHeight() +(sketched+1)*(ghotr) 
   );
  

//   line( -((i+1)* _cellWidth)+_cellPos[0]-i*ColumnOffset ,
//   getMaxHeight() +2+(sketched)*_columnLabelHeight/NUM_SEQUENCES -1,
//   -((i+1)* _cellWidth)+_cellPos[0]-i*ColumnOffset +  (_columnLabelWidth/num)*level,
//    getMaxHeight() +2+(sketched)*_columnLabelHeight/NUM_SEQUENCES -1
//   );
//  



  				sketched++; 

  			} // j  
  		}//i
  
  
  //************** test done ***********
  
  
  
  	}//render
  
  	void mousePressedInView(int x,int y) {
  
  		for(int i=0;i<NUM_CHARACTERS;i++)
  		{
  			if ( 
  					(x >= _cellPos[0] -(i+1)* _columnLabelWidth - i*ColumnOffset) && (x <= _cellPos[0] -(i)* _columnLabelWidth - i*ColumnOffset ) && 
  					(y <= _cellPos[1]) && ( y >= _cellPos[1] -2*_columnLabelHeight) 
  					) {
  
  				(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).SortbyCharactristics(i);
  
  statusBarText="Sequences sorted by " + database.CharactristicsHeader.getHeader(i);
  
  			} //if    
  
  		}//for
  
  		for(int i=0;i<NUM_CHARACTERS;i++){  
  			if ( 
  					(x >= _cellPos[0] -(i+1)* _columnLabelWidth - i*ColumnOffset)  && (x <= _cellPos[0] -(i)* _columnLabelWidth - i*ColumnOffset) && 
  					(y <= _cellPos[1]) && ( y >= _cellPos[1] -2*_columnLabelHeight) 
  					) {
   
  				int num=(  (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels )  .size());
  				lines=new int[num+1];
  				int li=0;
  				int prevousLevel=0;
  
  				int numberOfRows=( ((Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();
  				for(int j=0;j<(numberOfRows);j++){ 
  
  					int seqIndex=i;
  					String valueSeqLabel=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getHeader(j);
  					//seqIndex=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getIndex(valueSeqLabel);
  
  					seqIndex=database.getIndex(valueSeqLabel);
  					//  System.out.println(seqIndex + " " + j);  // Because the data is sorted too not just the headrers. It is because of the speed.
  
  					String valueChar=((Strain)((database._data).get(seqIndex))).getCharactristicsAt(i);    
  
  					int level=( (  (   (Cell)   (     (database.CharactristicsHeader)._Columns.get(i)    )    )._charLevels ).indexOf(valueChar));
  
  					if(level != prevousLevel){
  
  						lines[li]=j;
  						li++;
  						prevousLevel=level;
  					}
  
  				}//j  
  			}//fori
  
  		}
    
  		if ( 
  				(x >= (getMaxWidth() /4) ) && (x <=( getMaxWidth() /2 )) &&
  				(y >= 0) && ( y <= ((cellHeight/2)+2) )
  				)
  		{
  			ascend=false;
  		}
   
  
  		if ( 
  				(x >= 0 ) && (x <=( getMaxWidth()  /4)) &&
  				(y >= 0) && ( y <= ((cellHeight/2)+2) )
  				)
  		{
  			ascend=true;
  		}
  
  	}//mouse
  
  	void SortSeqOnChar(int i)	{  
  	}  
  
  	void RenderButtons(){
  		stroke( frameColor );
  		strokeWeight( frameWidth);
  		noFill();
  		rect(getMaxWidth() /4, 0 ,getMaxWidth()  /4, _columnLabelHeight/2+2);
  		fill( 0);
  		//textFont(_pixel_font_8b);
  		textFont( sans_10 );
  		textAlign( LEFT, BOTTOM );
  		text("descend",
  				_matrix_view_origin[0]+ getMaxWidth()/4 + 10, 
  				_matrix_view_origin[1] +0 + 14
  				);
  
  	stroke( frameColor );
  		strokeWeight( frameWidth);
  		noFill();
  		rect(0, 0,getMaxWidth()  /4, _columnLabelHeight/2+2);
  
  		fill( 0);
  		//textFont(_pixel_font_8b);
  		textFont( sans_10 );
  		textAlign( LEFT, BOTTOM );
  		text("ascend",
  				_matrix_view_origin[0] + 15, 
  				_matrix_view_origin[1] +0 + 14
  
  				);
  		if(ascend ){
  			stroke( BACKGROUND_COLOR );
  			strokeWeight( frameWidth);
  			line(0, _columnLabelHeight/2 +2,getMaxWidth()/4, _columnLabelHeight/2+2);
  
  		}
  		else{
  			stroke( BACKGROUND_COLOR );
  			strokeWeight(  frameWidth);
  			line(getMaxWidth() /4, _columnLabelHeight/2 +2, getMaxWidth() /2 , _columnLabelHeight/2 +2);
  		}
  	}
  
  	int getMaxWidth()  	{
  		int v = _width ;
  		return v;
  	}
  
  	int getMaxHeight(){
  		int v = _height;
  		return v;
  	}
  
  }
