  
  class PvalueView
  {
  	int _width, _height;
  	int[] _cellPos;  
  	int _cellWidth, _cellHeight;
  	int _seqLabelWidth, _seqLabelHeight;
  	int _columnLabelWidth=_cellWidth, _columnLabelHeight;
  	ArrayList _GroupData;
        int[] _sort_button_pos;
        int _sort_button_width;
        int _sort_button_heigth;
        String _sort_button_text;
        int cornerOffset=5;
  	// slider=filter
  
  	int _Pvalue_slider_x,_Pvalue_slider_y,_Pvalue_slider_w,_Pvalue_slider_r;
  
  	int width_WindowSize=16;
  	int height_WindowSize=10;
  
  	PvalueView(){
  		_cellWidth=30;
  		_cellHeight=30;
  		_seqLabelWidth=_cellWidth*2;
  		_seqLabelHeight=_cellHeight;
  		_columnLabelWidth=_cellWidth;
  		_columnLabelHeight=_cellHeight-5;
  		_cellPos = new int[2];
                _sort_button_pos=new int[2];
                _sort_button_text=new String("");
  		_cellPos[0]=0;
  		_cellPos[1]=-2*_columnLabelHeight;
  		_width=( NumberOfVisualizedPositions*_cellWidth) ;
  		_height= 90;
  
  		_Pvalue_slider_r=10;	
     setDimensions();	 
  	}
  
  	void setDimensions(){
  		_Pvalue_slider_w= getMaxWidth()/3;
  		_Pvalue_slider_x=_cellPos[0];
  		_Pvalue_slider_y=getViewHeight()-30;
                _sort_button_width=40;
                _sort_button_heigth=15;
                cornerOffset=15;
                _sort_button_pos[0]=_cellPos[0]+getViewWidth()-cornerOffset-_sort_button_width;
                _sort_button_pos[1]=0+getViewHeight()-cornerOffset-cornerOffset;            
                _sort_button_text="sort";
  	}
  
  	void render(){
 
  		int x_renderCounter=0;
  		int y_renderCounter=0;
  
  		strokeCap(SQUARE);
  		noSmooth();
  		
  
  		strokeCap(SQUARE);
  		noSmooth();
  		stroke( frameColor);
  		strokeWeight( frameWidth );
  		noFill();
  
  		rect(-30,0,  getViewWidth()+30,getViewHeight());  
  
  		noStroke();
  
  		strokeCap(SQUARE);
  		noSmooth();
  
  		strokeWeight(  SCROLL_LINE_WEIGHT );
  
  		stroke( SCROLL_BACKGROUND_COLOR );    
  		fill(130); 
  		stroke( SCROLL_BACKGROUND_COLOR *4); 
  
  		// 
  		// bars
  		//
  		int numberOfColumns=0;
  		if(!rowBased){
  			numberOfColumns=( ((Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).headerSize();
  		}else if(rowBased){
  			numberOfColumns=( ((Group)( (database._rowGroups).get(0) )).PositionHeader).headerSize();
  		}
  		if(!rowBased){
  			int sketched=0;
  			for(int i=x_start;((sketched< width_WindowSize) && (i<numberOfColumns));i++){
  				if(!(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){
  
  					float value=(( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).getpValue(i);
  					
                                        strokeWeight(BORDER_WEIGHT*2 );
                                        stroke((( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).getColor(i) );
                                        if((( (Group)( (database._columnGroups).get(selectedGroupIndex) )).PositionHeader).getColor(i) !=MOUSEOVER)
                                        stroke( SCROLL_BACKGROUND_COLOR );    
                                        int X_position=_cellPos[0] +(sketched)*cellWidth+cellWidth/2;
                                        
  					line(X_position,
  							- _cellPos[1],
  							X_position,
  							-_cellPos[1] + (   10 * ((float)Math.log(value))/((float)Math.log(10)) )
  							);  

  					fill( BACKGROUND_COLOR);
  
  					sketched++;
  				}
  			}
  		} // bars
  
  		renderPvalueSlider();		
                renderPvalueSortButton();
                
  	}//render
  
  	int getViewWidth(){ 
  		return _width;
  	}
  
  	int getViewHeight(){
  		return _height;
  	}

  	boolean overPvalueSlider( int x, int y ){
  		if ( (x >= _Pvalue_slider_x) && (x <= _Pvalue_slider_x+_Pvalue_slider_w +_Pvalue_slider_r/4) && 
  				(y >= _Pvalue_slider_y-_Pvalue_slider_r) && ( y <= _Pvalue_slider_y+_Pvalue_slider_r) ){
  			Pvalue =(float)(x- _Pvalue_slider_x) / (float) _Pvalue_slider_w;  
  			int numberOfColumns=( ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).headerSize();
  			for(int i=0 ; i< numberOfColumns ;i++){		
  				if(!(( (Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader).isCellFiltered(i,floor(_density*10))){
  					x_start=i;
  					i= numberOfColumns; // so that the loop ends faster!
  					//_X_scroll_min_pos = _x_scroll_pos[0];
  				}
  			}                      
  
  			return true;
  		}    
  		return false;
  	}
  
  	void renderPvalueSlider() {
  		stroke( BORDER_COLOR );
  		strokeWeight( 1 );
  
  		noFill();
  		stroke( BORDER_COLOR );
  
  		line( _Pvalue_slider_x, _Pvalue_slider_y-(_Pvalue_slider_r/2), _Pvalue_slider_x, _Pvalue_slider_y+(_Pvalue_slider_r/2) );
  		line( _Pvalue_slider_x+_Pvalue_slider_w, _Pvalue_slider_y-(_Pvalue_slider_r/2), _Pvalue_slider_x+_Pvalue_slider_w, _Pvalue_slider_y+(_Pvalue_slider_r/2) );
  		line( _Pvalue_slider_x, _Pvalue_slider_y, _Pvalue_slider_x+_Pvalue_slider_w, _Pvalue_slider_y );
  		//line( _Pvalue_slider_x, _Pvalue_slider_y-(_Pvalue_slider_r/2), _Pvalue_slider_x+_Pvalue_slider_w, _Pvalue_slider_y-(_Pvalue_slider_r/2) );
  		//line( _Pvalue_slider_x, _Pvalue_slider_y+(_Pvalue_slider_r/2), _Pvalue_slider_x+_Pvalue_slider_w, _Pvalue_slider_y+(_Pvalue_slider_r/2) );

  		strokeWeight( 8 );
  		stroke( BORDER_COLOR );
  		line(  _Pvalue_slider_x,  _Pvalue_slider_y, _Pvalue_slider_x+int(Pvalue*_Pvalue_slider_w),  _Pvalue_slider_y );
  		strokeWeight( 2 );
  
  		stroke( 0 );
  		fill( 130);
  		strokeWeight( 1 );
  		//  stroke( BORDER_COLOR );
  		ellipse( _Pvalue_slider_x+int(Pvalue*_Pvalue_slider_w), _Pvalue_slider_y, _Pvalue_slider_r, _Pvalue_slider_r );
  		fill( 256,256,256);
  		ellipse( _Pvalue_slider_x+int(Pvalue*_Pvalue_slider_w), _Pvalue_slider_y,  5, 5);
    
  		fill( BORDER_COLOR*2 );
  		textAlign( RIGHT, CENTER );
  		text( "1",  _Pvalue_slider_x+  _pvalue_view_origin[0]+(( _Pvalue_slider_w/10)*10), _Pvalue_slider_y+ _pvalue_view_origin[1]+15 );
  		text( "0.0005",  _Pvalue_slider_x+  _pvalue_view_origin[0]+(( _Pvalue_slider_w/5)*0), _Pvalue_slider_y+ _pvalue_view_origin[1]+15 );
  		text( "0.2",  _Pvalue_slider_x+  _pvalue_view_origin[0]+(( _Pvalue_slider_w/5)*1), _Pvalue_slider_y+ _pvalue_view_origin[1]+15 );
  		text( "0.39",  _Pvalue_slider_x+  _pvalue_view_origin[0]+(( _Pvalue_slider_w/5)*2), _Pvalue_slider_y+ _pvalue_view_origin[1]+15 );
  		text( "0.5",  _Pvalue_slider_x+  _pvalue_view_origin[0]+(( _Pvalue_slider_w/5)*3), _Pvalue_slider_y+ _pvalue_view_origin[1]+15 );
  	}
  void renderPvalueSortButton(){
                 stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		noFill();
                rect(_sort_button_pos[0],_sort_button_pos[1],_sort_button_width, _sort_button_heigth);
                fill( BORDER_COLOR*2 );
  		textAlign( RIGHT, CENTER );
  		text( _sort_button_text, _sort_button_pos[0]+_pvalue_view_origin[0]+ 30, _sort_button_pos[1]+ _pvalue_view_origin[1]+6 );
  }
      boolean overPvalueSorttButton( float x, float y ) {

  		if ( (x >= _sort_button_pos[0]) && (x <= _sort_button_pos[0]+ _sort_button_width) && 
  				(y >= _sort_button_pos[1]) && ( y <= _sort_button_pos[1]+_sort_button_heigth) ) {
  
                   // Order Column Header Order!
                   ((Group)( (_GroupData).get(selectedGroupIndex) )).PositionHeader.SortPositionOrderbyPvalue();
     statusBarText="Positions sorted on Pvalue!";
  			return true;
  		}    
  		return false;
  	}
  
  	int getMaxWidth(){
  		int v = 12*_cellWidth ;
  		return v;
  	}
  
  	int getMaxHeight(){
  		int v = 1*_columnLabelHeight;
  		return v;
  	}
  
  	void cellRolledOver(float x, float y){    
  
  	}
  
  	void mousePressedInView( float mx, float my){
        overPvalueSorttButton(mx,my);
  	}
  	void mouseDraggedInView( int mx, int my, boolean right_pressed ){
  
  	}
  	boolean mouseDraggedInView( float mx, float my){
  		if(mx>= 0 && mx<= _width && my>=0 && my <= _height){
  			overPvalueSlider( mx, my );          
  			return true;}
  		return false;
  	}
  
  	void mouseReleasedSomewhere(){
  
  	}
  
  	boolean overPvalueSlider( float x, float y ) {
  		if ( (x >= _Pvalue_slider_x) && (x <= _Pvalue_slider_x+_Pvalue_slider_w + _Pvalue_slider_r/2) && 
  				(y >= _Pvalue_slider_y-_Pvalue_slider_r) && ( y <= _Pvalue_slider_y+_Pvalue_slider_r) ) {
  
  			float movement =(float)(x- _Pvalue_slider_x) / (float) _Pvalue_slider_w; 
  
  			//_Pvalue_slider_x -=movement;
  
  			return true;
  		}    
  		return false;
  	}
  
  }//class

