  
  class MultialignView
  {
  	int _width, _height;
  	int[] _cellPos;  
  
  	int _seqLabelWidth;
  	int  _columnLabelHeight;
  
  	ArrayList _GroupData;
  
  	/** slider==filter
        */
        
  	int _density_slider_x,_density_slider_y,_density_slider_w,_density_slider_r;
  
  	//scroll bars to navigate
  	int[] _x_scroll_pos, _y_scroll_pos;
  	int _scroll_width, _scroll_offset, _x_scroll_length, _y_scroll_length;
  	boolean _over_x_scroll, _over_y_scroll;
  	int _over_x_scroll_pos, _over_y_scroll_pos;
  
  	boolean x_reachtoMax=false;
  	boolean y_reachtoMax=false;
  	float PreviousXslider;
  	float PreviousYslider;
  
  	float _X_scroll_min_pos;
  	float _Y_scroll_min_pos;
  	float _X_scroll_added;
  	float _Y_scroll_added;
  
  	float _x_scroll_slider_size;
  	float _y_scroll_slider_size;
  

  	float  _x_scroll_Movemenet_threshhold;
  	int NumberOfVisibleElements;
  
        int[] _reset_button_pos;
        int _reset_button_width;
        int _reset_button_heigth;
        String _reset_button_text;
        int cornerOffset;
         
        int[] _plusMinus_button_pos;
        int _plusMinus_button_width;
        int _plusMinus_button_heigth;
        String _plus_button_text;
        String _minus_button_text;

  	MultialignView()
  	{
  		_seqLabelWidth=60;
  		_columnLabelHeight=30-5;
  		_cellPos = new int[2];
  		_cellPos[0]=_seqLabelWidth;
  		_cellPos[1]=_columnLabelHeight;
                _plusMinus_button_pos= new int[2];
  
  		
                _reset_button_pos=new int[2];
                _reset_button_text=new String("");
  		_density_slider_r=10;
  

                _width=getMaxWidth();
                _height=getMaxHeight();
    
  		//scroll bars to navigate     
  		_x_scroll_pos = new int[2];
  		_y_scroll_pos = new int[2];
  
  		_over_x_scroll = _over_y_scroll = false;
  		_over_x_scroll_pos = _over_y_scroll_pos = 0;
  
  		x_start=0;
  		y_start=0;  
  		_X_scroll_added=0;
  		_Y_scroll_added=0;
  		_GroupData= new ArrayList();
              
  
  		setDimensions();
  	}
  	void colorLabel(){
  	}
  	void setDimensions(){
  		_x_scroll_pos[0] = _cellPos[0];
  		_x_scroll_pos[1] = _cellPos[1]+ getMaxHeight()+SCROLL_OFFSET;
  
  		_y_scroll_pos[0] = _cellPos[0]+getMaxWidth()+SCROLL_OFFSET ;
  		_y_scroll_pos[1] = _cellPos[1];
  
  		_density_slider_w= getMaxWidth()/3;
  
  		_density_slider_x=_cellPos[0];
  		_density_slider_y=getMaxHeight()+100;
  
  		_scroll_width = SCROLL_WIDTH;
  		_scroll_offset = SCROLL_OFFSET;
  
  		_x_scroll_length=getMaxWidth();
  		_y_scroll_length=getMaxHeight();
  
  		_X_scroll_min_pos = _x_scroll_pos[0];
  		_Y_scroll_min_pos = _y_scroll_pos[1];
  
  		PreviousXslider= _X_scroll_min_pos;
  		PreviousYslider= _Y_scroll_min_pos;
  
  		_y_scroll_slider_size=8*seqLabelHeight;
  
                _reset_button_width=40;
                _reset_button_heigth=15;
                cornerOffset=15;
                _reset_button_pos[0]=_cellPos[0]+getViewWidth()-cornerOffset-_reset_button_width;
                _reset_button_pos[1]=_density_slider_y-5;            
                _reset_button_text="reset";
                
               _plusMinus_button_width=15;
               _plusMinus_button_heigth=15;
                
                _plusMinus_button_pos[0]= _reset_button_pos[0]- 2*_plusMinus_button_width -cornerOffset;
                _plusMinus_button_pos[1]= _reset_button_pos[1];
                
                _plus_button_text="+";
                _minus_button_text="-";
                
  	}
   
  	void render(){
    if(!rowBased){
  		NumberOfVisibleElements=(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).numberOfVisibleCells(floor(_density*10));
    }
    else{
    NumberOfVisibleElements=(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).headerSize();
    
    }
  
  		if(NumberOfVisibleElements<=width_WindowSize)
  			NumberOfVisibleElements=width_WindowSize;
  
  		_x_scroll_Movemenet_threshhold= NumberOfVisibleElements/width_WindowSize;
  
  		_x_scroll_slider_size=(int)((columnLabelWidth)*(width_WindowSize)* (_x_scroll_length))/(int)((columnLabelWidth)*NumberOfVisibleElements);
  
  		if(_X_scroll_min_pos +  _x_scroll_slider_size > _x_scroll_pos[0] + _x_scroll_length){
  
  			if(_X_scroll_min_pos >=  _x_scroll_pos[0])
  				_X_scroll_min_pos=_x_scroll_pos[0] + _x_scroll_length - _x_scroll_slider_size;
  			else
  				_X_scroll_min_pos= _x_scroll_pos[0]; 
  		}
  
  		strokeCap(SQUARE);
  		noSmooth();
  
  		// x axis scroll bar
  
  		strokeWeight( SCROLL_LINE_WEIGHT );
  		stroke(frameColor ); 
  		line( _x_scroll_pos[0], _x_scroll_pos[1], _x_scroll_pos[0], _x_scroll_pos[1]+_scroll_width );
  		line( _x_scroll_pos[0], _x_scroll_pos[1]+_scroll_width/2, _x_scroll_pos[0]+_x_scroll_length, _x_scroll_pos[1]+_scroll_width/2 );
  		line( _x_scroll_pos[0]+_x_scroll_length, _x_scroll_pos[1], _x_scroll_pos[0]+_x_scroll_length, _x_scroll_pos[1]+_scroll_width );
  
  		strokeWeight( SCROLL_BAR_LINE_WEIGHT );
  		if ( !_over_x_scroll ) stroke( SCROLL_COLOR );
  		else stroke( SCROLL_SELECTED_COLOR );
  		//int _X_scroll_min_pos = _x_scroll_pos[0]+ x_start*columnLabelWidth;
  		//int max_pos = _X_scroll_min_pos+columnLabelWidth;
  		line( _X_scroll_min_pos, _x_scroll_pos[1]+_scroll_width/2, _X_scroll_min_pos+_x_scroll_slider_size, _x_scroll_pos[1]+_scroll_width/2 );
  
  		_over_x_scroll =false;
  
  		// y axis scroll bar
  		strokeWeight( SCROLL_LINE_WEIGHT );
  		stroke( SCROLL_BACKGROUND_COLOR );    
  		line( _y_scroll_pos[0], _y_scroll_pos[1], _y_scroll_pos[0]+_scroll_width, _y_scroll_pos[1] );
  		line( _y_scroll_pos[0]+_scroll_width/2, _y_scroll_pos[1], _y_scroll_pos[0]+_scroll_width/2, _y_scroll_pos[1]+_y_scroll_length );
  		line( _y_scroll_pos[0], _y_scroll_pos[1]+_y_scroll_length, _y_scroll_pos[0]+_scroll_width, _y_scroll_pos[1]+_y_scroll_length );
  
  		strokeWeight( SCROLL_BAR_LINE_WEIGHT );
  		if ( !_over_y_scroll ) stroke( SCROLL_COLOR );
  		else stroke( SCROLL_SELECTED_COLOR );
  
  		line( _y_scroll_pos[0]+_scroll_width/2, _Y_scroll_min_pos, _y_scroll_pos[0]+_scroll_width/2, _Y_scroll_min_pos+ _y_scroll_slider_size );
  
  		_over_y_scroll=false;
  
  		noStroke();
  
  		strokeCap(SQUARE);
  		noSmooth();
  
  		strokeWeight(  SCROLL_LINE_WEIGHT );
  
  		//
  		// render the position labels
  		int numberOfColumns=0;
  		//
  
  		numberOfColumns=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).headerSize();
    
  		int sketched=0;
  
  		for(int i=x_start;((sketched<width_WindowSize) && (i<numberOfColumns));i++)   ///**** For all the groups?!!!
  		{
  			if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){
  //originalSeq.getNucleotideAt(i)
  
  				String value=(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).getHeader(i);
  
  				stroke(SCROLL_BACKGROUND_COLOR );    
  
  				fill((( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).getColor(i) );
  				rect(_cellPos[0] +(sketched)* columnLabelWidth,0, columnLabelWidth,_columnLabelHeight);  
  				fill( BACKGROUND_COLOR );
  
  				textFont(_pixel_font_8b);
  if(cellWidth <20){
  textFont(_pixel_font_6b);}
  if(cellWidth <15){
  textFont(_pixel_font_4b);
  }
   if(cellWidth <5){
  textFont(_pixel_font_2b);
  }
  				textAlign( LEFT, BOTTOM );
  				text(value,
  						_align_view_origin[0]+ _cellPos[0]+ columnLabelWidth/2+(sketched)* columnLabelWidth-cellWidth/3, 
  						_align_view_origin[1]+ _columnLabelHeight/2+5
  						);
  
  
  
  //********* Original Sequence Label
  
  
  
    				 value=originalSeq.getNucleotideAt(i);
  
  				stroke(SCROLL_BACKGROUND_COLOR );    
  
  				fill(130);
  				rect(_cellPos[0] +(sketched)* columnLabelWidth, -25, columnLabelWidth,_columnLabelHeight);  
  				fill( BACKGROUND_COLOR );
  
  				textFont(_pixel_font_8b);
  if(cellWidth <20){
  textFont(_pixel_font_6b);}
  if(cellWidth <15){
  textFont(_pixel_font_4b);
  }
   if(cellWidth <5){
  textFont(_pixel_font_2b);
  }
  				textAlign( LEFT, BOTTOM );
  				text(value,
  						_align_view_origin[0]+ _cellPos[0]+ columnLabelWidth/2+(sketched)* columnLabelWidth-cellWidth/3, 
  						_align_view_origin[1]+ _columnLabelHeight/2+5 - 25
  						);
  
  //***********Original Sequence Label done
  
  
  
  
  
  
  
  
  				sketched++;
  
  			}//if
  		}
    
  		int numberOfRows=0;
  
  		numberOfRows=( ((Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();
  
  		sketched=0;
  		//
  		// render the sequence labels
  		//
  
  		for(int i=y_start;(sketched< (Math.floor((getMaxHeight())/(seqLabelHeight))) && i<numberOfRows);i++)
  		{
  			String value=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getHeader(i);   ////Not always 0 !!!!!
  			stroke( SCROLL_BACKGROUND_COLOR ); 
  			fill((( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getColor(i));
  			rect(0 ,(i-y_start)*cellHeight+_cellPos[1], _seqLabelWidth, seqLabelHeight);  
  			fill( BACKGROUND_COLOR);
  			textFont(_pixel_font_8b);
  			text(value,_seqLabelWidth/2+_align_view_origin[0], seqLabelHeight/2+_align_view_origin[1]+_cellPos[1]+(i-y_start)*cellHeight);
  			noStroke();
  			sketched++;
  
  		} // for number of sequences  // sequence labels done!
  
  		//
  		// render the nucleotides 
  		//                      
  
  		int seqSketched=0;
  		for(int i=y_start;((seqSketched<height_WindowSize)&&i<(numberOfRows));i++){
  
  			sketched=0;
  
  			for(int j=x_start;((sketched<width_WindowSize) && (j<numberOfColumns));j++){
  
  				if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(j,floor(_density*10))){
  
  					String value= (( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).getHeader(j);
  					int index=Integer.parseInt(value)-1;
  
  					//int seqIndex=i;
  					String valueSeqLabel=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getHeader(i);					
  
  					// seqIndex=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getIndex(valueSeqLabel);
  
  					value=database.getNucleotideAtBySeqLabel( valueSeqLabel ,index);
  
  					//value=((Strain)((database._data).get(seqIndex))).getNucleotideAt(index);          
  
  					if(!(value.equals("0")))
  					{
  						fill(SUBCELLS);
  						rect( ((sketched)* cellWidth)+_cellPos[0],_cellPos[1]+(seqSketched)*cellHeight, cellWidth, cellHeight);    
  						stroke( SCROLL_BACKGROUND_COLOR );    
  						fill(0);
  						textFont(_pixel_font_8b);
  						text(value,((sketched)* cellWidth)+(cellWidth/2)+_align_view_origin[0]+_cellPos[0],
  								_cellPos[1]+(seqSketched)*cellHeight+(cellHeight/2)+_align_view_origin[1]);
  					}
  					else  
  					{
  						fill(NONSUBCELLS);
  						stroke( SCROLL_BACKGROUND_COLOR );   
  						rect(   (sketched)* cellWidth+_cellPos[0],_cellPos[1]+(seqSketched)*cellHeight, cellWidth, cellHeight);    
  
  						fill(0);
  						textFont(_pixel_font_8b);
  						text(".",( (sketched) )* cellWidth+(cellWidth/2)+_cellPos[0]+_align_view_origin[0],_cellPos[1]+(seqSketched)*cellHeight+(cellHeight/2)+_align_view_origin[1]);
  
  					}
  
  					sketched++;
  				}
  			}
  			seqSketched++;                    
  		}
  
  		//
  		// render the boarder
  		//
  		noFill();
  		stroke( BORDER_COLOR );
  		strokeWeight(BORDER_WEIGHT );
  		rectMode( CORNER );
  		rect(_seqLabelWidth,_columnLabelHeight,  getMaxWidth(), getMaxHeight());  
  
  		renderdensitySlider();  
  
  		for(int i=0;i<lines.length;i++)
  		{
  			if(lines[i] > y_start && lines[i] <  y_start+(Math.floor((getMaxHeight())/(seqLabelHeight))) )
  			{
  				strokeWeight( 1 );
  				stroke( 0 ); 
  
  				line( _cellPos[0]  ,
  						((lines[i]-y_start)* cellHeight )+ _cellPos[1]  ,
  						getMaxWidth() +_cellPos[0] , 
  						((lines[i]-y_start)* cellHeight) + _cellPos[1]);
  			}
   
  		}
           renderResetSortButton();
           renderResetPlusMinusButtons();
  
  	}//render
  
  	//***********other functions:***********
  
  	int getViewWidth(){ 
  		return _width;
  	}
  
  	int getViewHeight(){
  		return _height;
  	}
  
  	boolean overdensitySlider( int x, int y ) {
  		if ( (x >= _density_slider_x) && (x <= _density_slider_x+_density_slider_w) && 
  				(y >= _density_slider_y-_density_slider_r) && ( y <= _density_slider_y+_density_slider_r) ) {
  
  			_density =(float)(x- _density_slider_x) / _density_slider_w;  
  			int numberOfColumns=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).headerSize();
  			for(int i=0 ; i< numberOfColumns ;i++){		
  				if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){
  					x_start=i;
  					i= numberOfColumns; // so that the loop ends faster!
  					_X_scroll_min_pos = _x_scroll_pos[0];
  				}
  			}                      
  
  			return true;
  		}    
  		return false;
  	}
  
  	boolean overXScrollbar( int x, int y ){       
  		float movement=0;    
  		int numberOfColumns;
  
  		numberOfColumns=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).headerSize();                   
  
  		NumberOfVisibleElements=(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).numberOfVisibleCells(floor(_density*10));
  
  		if ( (x >=  _X_scroll_min_pos -5  ) && (x <= _X_scroll_min_pos+ _x_scroll_slider_size +5) && 
  				(y >= _x_scroll_pos[1] -5 ) && ( y <= (_x_scroll_pos[1]+ _scroll_width +5)) ) {
  			movement = (float)(x-PreviousXslider)/(float)(1*_x_scroll_length ); 
  			movement=movement*10+1;
  
  			if((x-PreviousXslider) >0 && x_start<=(numberOfColumns-width_WindowSize)){
  				if((_X_scroll_min_pos+ _x_scroll_slider_size + +movement) <= (_x_scroll_length + _x_scroll_pos[0])){
  					_X_scroll_min_pos = _X_scroll_min_pos+movement;
  				}
  				_X_scroll_added+=movement;
  				if( _X_scroll_added >= columnLabelWidth/300){
  					for(int i=x_start+1 ; i< numberOfColumns ;i++){		
  						if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){
  							x_start=i;
  							i=NUM_NUCLEOTIDES;
  						}
  					}                                         
  					_X_scroll_added=0;
  				}
  			}
  			else if((x-PreviousXslider) < 0  &&  x_start>0){
  				movement=(float)(PreviousXslider-x)/(float)(1*_x_scroll_length);
  
  				movement=movement*10+1;
  				if ((_X_scroll_min_pos-movement) >= (_x_scroll_pos[0])){
  
  					_X_scroll_min_pos = _X_scroll_min_pos-movement;
  				}
  				_X_scroll_added+=movement;
  				if( _X_scroll_added >= columnLabelWidth/300 ){
  					for(int i=x_start-1 ; i>0 ;i--){		
  						if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){
  							x_start=i;
  							i=0;
  						}
  					}
  
  					_X_scroll_added=0;
  				}
  			}
  			_over_x_scroll =true;
  			return true;
  		}    
  		return false;
  	} //overXScrollbar
  
  	boolean overYScrollbar( int x, int y ) {
  		float movement=1; 
  		if ( (y >=  _Y_scroll_min_pos -5 ) && (y <= _Y_scroll_min_pos+ _y_scroll_slider_size +5) && 
  				(x >= _y_scroll_pos[0]) && ( x <= _y_scroll_pos[0]+ _scroll_width) ){
  
  			if((y-PreviousYslider) >0 && y_start<=(NUM_SEQUENCES-height_WindowSize)){
  				if((_Y_scroll_min_pos+_y_scroll_slider_size) < (_y_scroll_length + _y_scroll_pos[1])){
  					movement=(float)(y-PreviousYslider)/(float)_y_scroll_length;
  					movement=movement*10+1;
  					_Y_scroll_min_pos = _Y_scroll_min_pos+movement;
  				}
  				_Y_scroll_added+=movement;
  				if( _X_scroll_added >= seqLabelHeight/40 ){
  					y_start+=1;
  					_Y_scroll_added=0;
  				}
  			}
  			else if((y-PreviousYslider) < 0  &&  y_start>0){
  				if ((_Y_scroll_min_pos) > (_y_scroll_pos[1])){
  					movement=(float)(PreviousYslider-y)/(float)_y_scroll_length;
  					movement=movement*10+1;
  					_Y_scroll_min_pos = _Y_scroll_min_pos-movement;
  				}
  				_Y_scroll_added+=movement;
  				if( _Y_scroll_added >= seqLabelHeight/40 ){
  					y_start-=1;
  					_Y_scroll_added=0;
  				}
  			}
  			_over_y_scroll =true;
  			return true;
  		}    
  		return false;
  	} //overYScrollbar
  
  	void renderdensitySlider() {
  
  		strokeWeight( 1 );
  		stroke( 0 );
  		stroke( BORDER_COLOR );
  
  		line( _density_slider_x, _density_slider_y-(_density_slider_r/2), _density_slider_x, _density_slider_y+(_density_slider_r/2) );
  		line( _density_slider_x+_density_slider_w, _density_slider_y-(_density_slider_r/2), _density_slider_x+_density_slider_w, _density_slider_y+(_density_slider_r/2) );
  		line( _density_slider_x, _density_slider_y, _density_slider_x+_density_slider_w, _density_slider_y );
  
  		stroke( 0 );
  
  		strokeWeight( 8 );
  		stroke( BORDER_COLOR );
  		line( _density_slider_x+int(_density*_density_slider_w),  _density_slider_y ,  _density_slider_x+_density_slider_w,_density_slider_y);
  
  		stroke( 0 );
  
  		strokeWeight( 1 );
  
  		fill( 130);
  		ellipse( _density_slider_x+int(_density*_density_slider_w), _density_slider_y, _density_slider_r, _density_slider_r );
  		fill( 256,256,256);
  		ellipse( _density_slider_x+int(_density*_density_slider_w), _density_slider_y, 5, 5);
  
  		fill( 0 );
  		textFont( sans_10 );
  		textAlign( LEFT, BOTTOM );
  		text( "density column filtering", _density_slider_x+_align_view_origin[0], _density_slider_y - (_density_slider_r+2) +_align_view_origin[1]);
  
  		textAlign( RIGHT, CENTER );
  		text( "No filter", _density_slider_x-8+_align_view_origin[0], _density_slider_y+_align_view_origin[1] );
  		textAlign( LEFT, CENTER ); 
  		text( "10 ore more substitutions", _density_slider_x+_density_slider_w+3+_align_view_origin[0], _density_slider_y+_align_view_origin[1]);
  
  		fill( BORDER_COLOR*2 );
  		textAlign( RIGHT, CENTER );
  		text( "1", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*1.5), _density_slider_y+_align_view_origin[1]+15 );
  		text( "2", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*2.5), _density_slider_y+_align_view_origin[1]+15 );
  		text( "3", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*3.5), _density_slider_y+_align_view_origin[1]+15 );
  		text( "4", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*4.5), _density_slider_y+_align_view_origin[1]+15 );
  		text( "5", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*5.5), _density_slider_y+_align_view_origin[1]+15 );
  		text( "6", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*6.5), _density_slider_y+_align_view_origin[1]+15 );
  		text( "7", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*7.5), _density_slider_y+_align_view_origin[1]+15 );
  		text( "8", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*8.5), _density_slider_y+_align_view_origin[1]+15 );
  		text( "9", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*9.5), _density_slider_y+_align_view_origin[1]+15 );
  		//text( "10", _density_slider_x+_align_view_origin[0]+((_density_slider_w/10)*10.5), _density_slider_y+_align_view_origin[1]+15 );
  	}
  void renderResetSortButton(){
                stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		noFill();
                rect(_reset_button_pos[0],_reset_button_pos[1],_reset_button_width, _reset_button_heigth);
                fill( BORDER_COLOR*2 );
  		textAlign( RIGHT, CENTER );
  		text( _reset_button_text, _reset_button_pos[0]+_align_view_origin[0]+30, _reset_button_pos[1]+ _align_view_origin[1]+6 );
  }
    	boolean overResetButton( float x, float y ) {

  		if ( (x >= _reset_button_pos[0]) && (x <= _reset_button_pos[0]+ _reset_button_width) && 
  				(y >= _reset_button_pos[1]) && ( y <= _reset_button_pos[1]+_reset_button_heigth) ) {
  
                   // Order Column Header Order!
                   ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader.SortToDefaultPositionOrder();
  			return true;
  		}    
  		return false;
  	}
  
  void renderResetPlusMinusButtons(){
     stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		noFill();
                rect(_plusMinus_button_pos[0],_plusMinus_button_pos[1],_plusMinus_button_width, _plusMinus_button_heigth);
                rect(_plusMinus_button_pos[0]+cornerOffset/3+_plusMinus_button_width,_plusMinus_button_pos[1],_plusMinus_button_width, _plusMinus_button_heigth);
                fill( BORDER_COLOR*2 );
  		textAlign( RIGHT, CENTER );
  		text( _plus_button_text, _plusMinus_button_pos[0]+_align_view_origin[0]+_plusMinus_button_width/2+4, _plusMinus_button_pos[1]+ _align_view_origin[1]+6 );
                text( _minus_button_text, _plusMinus_button_pos[0]+cornerOffset/3+_plusMinus_button_width+_align_view_origin[0]+_plusMinus_button_width/2+4, _plusMinus_button_pos[1]+ _align_view_origin[1]+6 );

  }
  boolean overPlusMinusButtons( float x, float y ) {
    
   if ( (x >= _plusMinus_button_pos[0]) && (x <= _plusMinus_button_pos[0]+ _plusMinus_button_width) && 
  				(y >= _plusMinus_button_pos[1]) && ( y <= _plusMinus_button_pos[1]+_plusMinus_button_heigth) ) {
  int spotW=cellWidth/4;
   int spotH=cellHeight/4;
   
    cellWidth+=spotW;
    columnLabelWidth=cellWidth;
    cellHeight+=spotH;
    seqLabelHeight=cellHeight;
     width_WindowSize =  _width/cellWidth;
 height_WindowSize = _height/cellHeight;
 
   		_insideCellWidth+=1;
  		_insideCellHeight=_insideCellWidth;
  if(_insideCellWidth>5){
             		 _insideCellWidth=5;
  		 _insideCellHeight=_insideCellWidth;
  }
   
  			return true;
  		}    
  
  else if ( (x >= _plusMinus_button_pos[0] + cornerOffset/3+_plusMinus_button_width ) && 
  (x <= _plusMinus_button_pos[0]+ _plusMinus_button_width + cornerOffset/3+_plusMinus_button_width) && 
  				(y >= _plusMinus_button_pos[1]) && ( y <= _plusMinus_button_pos[1]+_plusMinus_button_heigth) ) {
  
   int spotW=cellWidth/4;
   int spotH=cellHeight/4;
    cellWidth-=spotW;
    columnLabelWidth=cellWidth;
cellHeight-=spotH;
seqLabelHeight=cellHeight;

 //width_WindowSize += (spot*width_WindowSize)/cellWidth;
 width_WindowSize =  _width/cellWidth;
// height_WindowSize +=round ((spot*height_WindowSize)/cellHeight);
 height_WindowSize = _height/cellHeight;
   		_insideCellWidth-=1;
  		_insideCellHeight=_insideCellWidth;
  
    if(_insideCellWidth<2){
             		 _insideCellWidth=2;
  		 _insideCellHeight=_insideCellWidth;
  }
  
 
  			return true;
  		} 
  
  return false;
  }
  
  	int getMaxWidth(){
  		int v = width_WindowSize*cellWidth ;
  		return v;
  	}
  
  	int getMaxHeight(){
  		int v = height_WindowSize*cellHeight;
  		return v;
  	}
  
  	boolean cellRolledOverInCreatedGroup(){
  		return false;
  	}
  
  	void setSliderValues(){
  	}
  
  	void mousePressedInView( float mx, float my){
          if(overResetButton(mx,my)){
          // Set the staturs bar
          statusBarText="Positions set to their default order";
          }
          overPlusMinusButtons(mx, my);
          
  	}
  
  	void mouseMovedInView( float mx, float my){
  	}    
  }
  
  class RowMultialignView extends MultialignView{
  	RowMultialignView(){
  		super();
  	}
  
  	void colorRowLabel(Cell c, int newColor){
  		c.setColor(newColor);
  	}
  	void colorLabel(){
  		if(selec != null){
  			int i=((  (Group)((_GroupData).get(selectedGroupIndex)) ).SequenceLabelHeader).getIndex(selec.label);
  			if( i>=0){
  
  				colorRowLabel( 
  						(  (Cell) 
  								((  (Group)((_GroupData).get(selectedGroupIndex)) ).SequenceLabelHeader)._Columns.get(i))
  								, MOUSEOVER);
  				// selec=null;
  			}
  		}
  	}
  	void mousePressedInView( float mx, float my){
        super.mousePressedInView(mx,my);
  		int sketched=0;
  		int numberOfRows=( ((Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();
  
  		for(int i=y_start;((sketched<height_WindowSize) && (i<numberOfRows));i++)
  		{
  			//	if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).isCellFiltered(i,floor(_density*10))){
  
  
  			if( my>= (_cellPos[1]+(sketched* cellWidth) ) && my<= (_cellPos[1]+((sketched+1)* cellWidth))  &&
  					mx>=( _cellPos[0] )&& mx<= getMaxWidth()+_cellPos[0] ){
  
  				String value=(( (Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getHeader(i);    
  
  
  				if((loadGroupIndex != selectedGroupIndex)&&(!  
  						((       (Group)((_GroupData).get(loadGroupIndex))      ).SequenceLabelHeader)._Columns.contains(
  								(Cell) 
  								((          (Group)((_GroupData).get(selectedGroupIndex))         ).SequenceLabelHeader)._Columns.get(i)
  
  								)
  
  						)){
  
  					((       (Group)((_GroupData).get(loadGroupIndex))      ).SequenceLabelHeader)._Columns.add(
  							(Cell) 
  							((          (Group)((_GroupData).get(selectedGroupIndex))         ).SequenceLabelHeader)._Columns.get(i)
  
  							);
  
  					(  (Cell) 
  							((          (Group)((_GroupData).get(selectedGroupIndex))         ).SequenceLabelHeader)._Columns.get(i))._color=130;
  
String newValue=value;			
statusBarText="Row " +newValue+" is added to a new group.";  				
}
  				i=numberOfRows;
  			}
  
  			sketched++;
  
  			//	}
  
  		} // position labels

  	}
  
  	void mouseMovedInView( float mx, float my){ //RowMultialignView 
  
  
  if((my-_cellPos[1])>0){
  		int sketched=0;
  		String value;
  		int numberOfrows=( ((Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();
  if(selec !=null){
  String val=selec.label;
  int in=( ((Group)( (_GroupData).get(selectedGroupIndex) )).SequenceLabelHeader).getIndex(val);
  (  (Cell) 
  							((         (Group)((_GroupData).get(selectedGroupIndex))         ).SequenceLabelHeader)._Columns.get(in))._color=130;
   selec=null;
}

 
  
  
  		for(int i=y_start;((sketched<height_WindowSize)) && i<numberOfrows;i++)
  		{
  
  
  			if( my>= (_cellPos[1]+(sketched* cellWidth) ) && my<= (_cellPos[1]+((sketched+1)* cellWidth))  && mx>=( _cellPos[0] )&& mx<= getMaxWidth() + _cellPos[0]){                                								
  
  				//if(loadGroupIndex !=0){
  
  				colorRowLabel((  (Cell) 
  						((  (Group)((_GroupData).get(selectedGroupIndex)) ).SequenceLabelHeader)._Columns.get(i)),MOUSEOVER);
  
  
  				String selecLabel=
  						(  (Cell) 
  								((  (Group)((_GroupData).get(selectedGroupIndex)) ).SequenceLabelHeader)._Columns.get(i)).getPositionLabel();
  
  				//selec=null;
  				for (int ii = 0; ii < rowNodeCount; ii++) {
  					if( (rowNodes[ii].label).equals(selecLabel))
  						selec = rowNodes[ii];
  				}
i=numberOfrows;
  			}
//  			else{
//  				if( (  (Cell) 
//  						((         (Group)((_GroupData).get(selectedGroupIndex))         ).SequenceLabelHeader)._Columns.get(i))._color!=130){
//  					(  (Cell) 
//  							((         (Group)((_GroupData).get(selectedGroupIndex))         ).SequenceLabelHeader)._Columns.get(i))._color=130;
//  					i=numberOfrows;
//  				}
//  			}
  
  			sketched++;
  
  			//}
  
  		} // position labels

  	}
  }
  }
  
  
  class ColumnMultialignView extends MultialignView
  {
  	ColumnMultialignView(){
  		super();
  	}
  	void colorColumnLabel(Cell c, int newColor){
  		c.setColor(newColor);
  	}
  	void colorLabel(){
  		if(selec != null){
  			int i=((  (Group)((_GroupData).get(selectedGroupIndex)) ).PositionHeader).getIndex(selec.label);
  			if( i>=0){

  				colorColumnLabel( 
  						(  (Cell) 
  								((  (Group)((_GroupData).get(selectedGroupIndex)) ).PositionHeader)._Columns.get(i))
  								, MOUSEOVER);
  				// selec=null;
  			}
  		}
  	} // color lael
  
  	void mousePressedInView( float mx, float my){
   super.mousePressedInView( mx,my);
  		int sketched=0;
  		int numberOfColumns=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).headerSize();
  
  		for(int i=x_start;((sketched<width_WindowSize) && (i<numberOfColumns));i++)
  		{
  			if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){
  
  
  				if( mx>= (_cellPos[0]+(sketched* cellWidth) ) && mx<= (_cellPos[0]+((sketched+1)* cellWidth))  && my>=( _cellPos[1] )&& my<= getMaxHeight()+_cellPos[1] ){
  
  					String value=(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).getHeader(i);                      
  
  					if((loadGroupIndex != selectedGroupIndex)&&(!  
  							((       (Group)((_GroupData).get(loadGroupIndex))      ).PositionHeader)._Columns.contains(
  									(Cell) 
  									((          (Group)((_GroupData).get(selectedGroupIndex))         ).PositionHeader)._Columns.get(i)
  
  									)
  
  							)){
  
  						((       (Group)((_GroupData).get(loadGroupIndex))      ).PositionHeader)._Columns.add(
  								(Cell) 
  								((          (Group)((_GroupData).get(selectedGroupIndex))         ).PositionHeader)._Columns.get(i)
  
  								);
  
  						(  (Cell) 
  								((          (Group)((_GroupData).get(selectedGroupIndex))         ).PositionHeader)._Columns.get(i))._color=130;
  
  		String newValue=value;			
statusBarText="column " +newValue+" is added to a new group.";
}
  					i=numberOfColumns;
  				}
  
  				sketched++;
  
  			}
  
  		} // position labels
  
  	}
  
  	void mouseMovedInView( float mx, float my){ //ColumnMultialignView
  		
  if((mx-_cellPos[0])>0){
  
  int sketched=0;
  		String value;
  		int numberOfColumns=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).headerSize();
  
    if(selec !=null){
      
      
  String val=selec.label;
  int in=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).getIndex(val);
  (  (Cell) 
  	((         (Group)((_GroupData).get(selectedGroupIndex))  ).PositionHeader)._Columns.get(in))._color=130;
   selec=null;
}


   if(CellColumnSelec!=null){
     String val=CellColumnSelec.getPositionLabel();
  int in=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).getIndex(val);
  (  (Cell) 
  	((         (Group)((_GroupData).get(selectedGroupIndex))  ).PositionHeader)._Columns.get(in))._color=130;
   CellColumnSelec=null;
   
   }



 int Indexchandomi=floor((mx-_cellPos[0])/cellWidth);
  int too=0;
 
 
 
  		for(int i=x_start;((sketched<width_WindowSize) && (i<numberOfColumns)) && (Indexchandomi) >=0;i++)
  		{
  
  			if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){  
  
  		                               								
   too=i;
   Indexchandomi--;
  	sketched++;
  					}
  }
  
  					colorColumnLabel((  (Cell) 
  							((  (Group)((_GroupData).get(selectedGroupIndex)) ).PositionHeader)._Columns.get(too)),MOUSEOVER);
  
  
  	String selecLabel=
  				(  (Cell) 
  				((  (Group)((_GroupData).get(selectedGroupIndex)) ).PositionHeader)._Columns.get(too)).getPositionLabel();
  

  selec=new Node(selecLabel);
//  					for (int ii = 0; ii < columnNodeCount; ii++) {
//  						if( (columnNodes[ii].label).equals(selecLabel))
//  							selec = columnNodes[ii];
//  
//  					}
//  
  
  CellColumnSelec=new Cell(selecLabel);
  			
//
//  		for(int i=x_start;((sketched<width_WindowSize) && (i<numberOfColumns));i++)
//  		{
//  
//  			if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){  
//  
//  				if( mx>= (_cellPos[0]+(sketched* cellWidth) ) && mx<= (_cellPos[0]+((sketched+1)* cellWidth))  && my>=( _cellPos[1] )&& my<= getMaxHeight()+_cellPos[1] ){                                								
//  
//  					//if(loadGroupIndex !=0){
//  
//  					colorColumnLabel((  (Cell) 
//  							((  (Group)((_GroupData).get(selectedGroupIndex)) ).PositionHeader)._Columns.get(i)),MOUSEOVER);
//  
//  
//  					String selecLabel=
//  							(  (Cell) 
//  									((  (Group)((_GroupData).get(selectedGroupIndex)) ).PositionHeader)._Columns.get(i)).getPositionLabel();
//  
//  					for (int ii = 0; ii < columnNodeCount; ii++) {
//  						if( (columnNodes[ii].label).equals(selecLabel))
//  							selec = columnNodes[ii];
//  					}
//  
//
//  				} // moved over a position 
//  				else{
//  					if( (  (Cell) 
//  							((          (Group)((_GroupData).get(selectedGroupIndex))         ).PositionHeader)._Columns.get(i))._color!=130){
//  						(  (Cell) 
//  								((          (Group)((_GroupData).get(selectedGroupIndex))         ).PositionHeader)._Columns.get(i))._color=130;
//  						//i=numberOfColumns;
//  					}
//  				}
//  
//  				sketched++;
//  
//  			}
//  
//  		} // position labels
//  
  	} //method
  }
  
  }//class
  
  
  
  

