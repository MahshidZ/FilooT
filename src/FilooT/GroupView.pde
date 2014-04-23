  
  class GroupView{
  	int _width, _height;
  	int _cellWidth, _cellHeight;
  	int view_Offset;
  	//int _insideCellHeight,_insideCellWidth;
  	int _columnLabelWidth, _columnLabelHeight;
  	int[] _cellPos; 
  
  	// slider=filter
  	int _density_slider_x,_density_slider_y,_density_slider_w,_density_slider_r;
  
  	boolean x_reachtoMax=false;
  	boolean y_reachtoMax=false;
  
  	ArrayList _GroupData;
  	int[] _save_button_pos, _load_button_pos; 
  	String _save_name;
  	int _text_box_width, _text_box_height, _button_width, _button_height;
  	int betweenGroupsOffset=5;
  
  	GroupView()
  	{
  		_cellWidth=110;
  		_cellHeight=_cellWidth;
  
  		view_Offset=18;

  		_columnLabelWidth=_cellWidth/2;
  		_columnLabelHeight=20;
  
                  _width=140;
  		  _height=590;
  
  		_density_slider_r=10;
  		_GroupData= new ArrayList();
  		_cellPos = new int[2];
  		_cellPos[0]= view_Offset-betweenGroupsOffset-2;
  		_cellPos[1]=view_Offset+_columnLabelHeight;
  		_save_button_pos = new int[2];
  		_load_button_pos = new int[2];
  		_button_width = SAVE_LOAD_VIEW_BUTTON_WIDTH;
  		_button_height = SAVE_LOAD_VIEW_BUTTON_HEIGHT;
  		_text_box_height = SAVE_LOAD_VIEW_BUTTON_HEIGHT;
  		_save_name = "";
  		setDimensions();
  	}
  	void setDimensions(){
  		_text_box_width = 60;
  		//_save_button_pos[0] = getViewWidth() - view_Offset - _button_width;
                _save_button_pos[0] = getViewWidth() - view_Offset - 1*_button_width;
  		_save_button_pos[1] = _cellPos[1] -25;
  		_load_button_pos[0] =  _cellWidth -  _button_width;
  		_load_button_pos[1] = _cellHeight +5 ;
  	}
  	void render(){
  		strokeCap(SQUARE);
  		noSmooth();
  		stroke(  frameColor );
  		strokeWeight(  frameWidth );
  		noFill();
  		rect(0,0,  getMaxWidth(),getMaxHeight());    
                SetGroupPositions();
  		renderCreateGroupButtons();               
  		//renderOverViews(); 
renderOveiwsSecond();  
  
  	} //render
  
  void SetGroupPositions(){
   int XPositionStep= _cellWidth+betweenGroupsOffset;
   int YPositionStep= _cellHeight + 2*betweenGroupsOffset + _button_height ;
    int GroupWidth= _cellWidth;
    int GroupHeigth= _cellHeight;
    int Xstart=view_Offset;
    int Ystart= view_Offset+_columnLabelHeight;
    int NumberInLastRow=1;
    int NumberInLastColumn=1;
   int XRightBoundry=getViewWidth();
    int YDwonBoundry=getMaxHeight();
  
    ( (Group)( (_GroupData).get(0) )).SetXposition(Xstart);
    ( (Group)( (_GroupData).get(0) )).SetYposition(Ystart);
  
    for(int k=1;k<_GroupData.size();k++){
      
      if( (Xstart+(NumberInLastRow+1)*XPositionStep)< XRightBoundry){
     ( (Group)( (_GroupData).get(k) )).SetXposition(Xstart+(NumberInLastRow)*XPositionStep);  
     NumberInLastRow++;
      }
      else if((Ystart+(NumberInLastColumn+1)*YPositionStep)< YDwonBoundry){
        XRightBoundry=getViewWidth();
        NumberInLastRow=0;
           ( (Group)( (_GroupData).get(k) )).SetXposition(Xstart+ (NumberInLastRow)*XPositionStep);  
     NumberInLastRow++;
      }//else X
      else if((Ystart+(NumberInLastColumn+1)*YPositionStep)> YDwonBoundry){
      
       ( (Group)( (_GroupData).get(k) )).SetXposition(-1);
      }
      if(NumberInLastRow ==1){
      if( (Ystart+(NumberInLastColumn+1)*YPositionStep)< YDwonBoundry){
  ( (Group)( (_GroupData).get(k) )).SetYposition(Ystart+(NumberInLastColumn)*YPositionStep); 
  
    NumberInLastColumn++;
      }
      else{
       ( (Group)( (_GroupData).get(k) )).SetYposition(-1); 
      }
   
      }//if
      else if(NumberInLastRow !=1){
        ( (Group)( (_GroupData).get(k) )).SetYposition(Ystart+(NumberInLastColumn-1)*YPositionStep); 
      }
      
    }//k
  }//SetGroupPositions
  
  	void renderOverViews(){
  		for(int k=0;k<_GroupData.size();k++){
  			// Boundries:
  			stroke( SCROLL_BACKGROUND_COLOR );
  			strokeWeight(  SCROLL_LINE_WEIGHT *2);
  			noFill();

  			int height_WindowSize=(( (Group)( (_GroupData).get(k) )).SequenceLabelHeader).headerSize();
  			int width_WindowSize=(( (Group)( (_GroupData).get(k) )).PositionHeader).headerSize();
  
  			//inside:
  			strokeWeight(  SCROLL_LINE_WEIGHT);   
  			int seqSketched=0;
  			int posSketched=0;
  			int Ystart=0;
  			if(k==selectedGroupIndex)
  				Ystart=y_start;
  			for(int i=Ystart;i<( height_WindowSize) && seqSketched<(_cellWidth/_insideCellWidth);i++){  //rows
  
  				posSketched=0;
  				int Xsta=x_start;
  
  				if(k != selectedGroupIndex)  
  				{
  					Xsta=0;
  				}
  				for(int j=Xsta;(j<(width_WindowSize)) && (posSketched<(_cellHeight/_insideCellHeight ));j++){  //columns 
  					boolean FilterNotMattered=true;
  					if(k==selectedGroupIndex){
  						FilterNotMattered=!(( (Group)( (_GroupData).get(k) )).PositionHeader).isCellFiltered(j,floor(_density*10));
  					} 
  					if( FilterNotMattered){
  						String value= (( (Group)( (_GroupData).get(k) )).PositionHeader).getHeader(j);
  
  						int index=Integer.parseInt(value)-1;
  						//int seqIndex=i;
  
  						String valueSeqLabel=(( (Group)( (_GroupData).get(k) )).SequenceLabelHeader).getHeader(i);     
  
  						//seqIndex=(( (Group)( (_GroupData).get(k) )).SequenceLabelHeader).getIndex(valueSeqLabel);      
  
  						//value=((Strain)((database._data).get(seqIndex))).getNucleotideAt(index);        
                                 value=database.getNucleotideAtBySeqLabel( valueSeqLabel ,index);
  
  						if(!(value.equals("0"))){
  							fill(SUBCELLS);
  							stroke( SCROLL_BACKGROUND_COLOR );  
  							rect( ( (Group)( (_GroupData).get(k) )).X+((posSketched)* _insideCellWidth),
  									(seqSketched)*_insideCellHeight+( (Group)( (_GroupData).get(k) )).Y,
  									_insideCellWidth, _insideCellHeight);    
  						}
  						else {
  							fill(NONSUBCELLS);
  							stroke( SCROLL_BACKGROUND_COLOR );   
  							rect(   ( (Group)( (_GroupData).get(k) )).X+(posSketched)* _insideCellWidth,
                                                                (seqSketched)* _insideCellHeight+( (Group)( (_GroupData).get(k) )).Y,
                                                                _insideCellWidth, 
                                                                _insideCellHeight);    
  						}
  
  						posSketched++;
  					}
  				}
  				seqSketched++;
  			}
  
  
    			stroke( SCROLL_BACKGROUND_COLOR );
  			strokeWeight(  SCROLL_LINE_WEIGHT );
  			noFill();
  
  
     if(k == selectedGroupIndex){
  stroke( 0 );
  			
  noFill();
     }
  
  			//rect(view_Offset+ (k*(_cellWidth+betweenGroupsOffset)) , view_Offset+_columnLabelHeight, _cellWidth,_cellHeight);
             if(( (Group) ( (_GroupData).get(k) )   ).X > 0 && ( (Group)( (_GroupData).get(k) )).Y >0 ){
                     rect(( (Group) ( (_GroupData).get(k) )   ).X , ( (Group)( (_GroupData).get(k) )).Y, _cellWidth,_cellHeight);
              }
  
  		}
  
  	}
  
  
  
  
  
  //************* test
  
  
  
    	void renderOveiwsSecond(){
      
      
      
  		for(int k=0;k<_GroupData.size();k++){
    
    int Poskeshide=0;
    
  			// Boundries:
  			stroke( SCROLL_BACKGROUND_COLOR );
  			strokeWeight(  SCROLL_LINE_WEIGHT *2);
  			noFill();

  			int height_WSize=(( (Group)( (_GroupData).get(k) )).SequenceLabelHeader).headerSize();
  			int width_WSize=(( (Group)( (_GroupData).get(k) )).PositionHeader).headerSize();
  
  
     int VisiW=(( (Group)( (_GroupData).get(k) )).PositionHeader).numberOfVisibleCells(floor(_density*10));
     int VisiH=height_WSize;

     
     if(VisiW > 0 ){
     if( (_cellWidth/ VisiW) >   DEFAULT_INSIDTE_WIDTH){
         DEFAULT_INSIDTE_WIDTH=_cellWidth/ VisiW ;

         
          _insideCellWidth=DEFAULT_INSIDTE_WIDTH;
  		 _insideCellHeight=DEFAULT_INSIDTE_HEIGTH;
         
         
     } 
     else if( (_cellWidth/ VisiW) <3){
     
      DEFAULT_INSIDTE_WIDTH=3;
       _insideCellWidth=DEFAULT_INSIDTE_WIDTH;
  		 _insideCellHeight=DEFAULT_INSIDTE_HEIGTH;
      
      
     }
     
     
     }
     
    if(VisiH > 0 ){
 if((_cellHeight/VisiH) >  DEFAULT_INSIDTE_HEIGTH){
    DEFAULT_INSIDTE_HEIGTH=_cellHeight/VisiH;
     _insideCellWidth=DEFAULT_INSIDTE_WIDTH;
  		 _insideCellHeight=DEFAULT_INSIDTE_HEIGTH;
 }
 else if((_cellHeight/VisiH) <2  )
 {
   
   DEFAULT_INSIDTE_HEIGTH=2;
     _insideCellWidth=DEFAULT_INSIDTE_WIDTH;
  		 _insideCellHeight=DEFAULT_INSIDTE_HEIGTH;
   
 }
 
 
  }
 
  
  
  			//inside:
  			strokeWeight(  SCROLL_LINE_WEIGHT);   
  			int seqSketched=0;
  			int posSketched=0;

  
  	int Xsta=x_start;
 
  
  				if(k != selectedGroupIndex)  
  				{
  					Xsta=0;
  				}
  
  			for(int i=Xsta;i<( width_WSize) && posSketched<(((_cellWidth-_insideCellWidth)/_insideCellWidth)+1);i++){  //columns
  Poskeshide=0;
  
     	boolean FilterNotMattered=true;
  					//if(k==selectedGroupIndex){
  						FilterNotMattered=!(( (Group)( (_GroupData).get(k) )).PositionHeader).isCellFiltered(i,floor(_density*10));
  					//} 
  					if( FilterNotMattered){ 
  
  				seqSketched=0;
  
  
  			  			int Ystart=0;
  			if(k==selectedGroupIndex){
  				Ystart=y_start;
  }
  		for(int j=Ystart;(j<(height_WSize)) && (seqSketched<(((_cellHeight-_insideCellHeight )/_insideCellHeight ))+1);j++){ //rows
   
  
  						String value= (( (Group)( (_GroupData).get(k) )).PositionHeader).getHeader(i);
  
  						int index=Integer.parseInt(value)-1;
  						String valueSeqLabel=(( (Group)( (_GroupData).get(k) )).SequenceLabelHeader).getHeader(j);      
                                                value=database.getNucleotideAtBySeqLabel( valueSeqLabel ,index);
  

  
  						if(!(value.equals("0"))){
  							
 //strokeWeight(1);
 stroke( SCROLL_BACKGROUND_COLOR*2 ); 
 
 fill(SCROLL_BACKGROUND_COLOR );
 if(!rowBased){
   
   if(((( (Group)( (_GroupData).get(k) )).PositionHeader).getColor(i)) == MOUSEOVER && (k==selectedGroupIndex)){
             fill(MOUSEOVER);
             stroke( MOUSEOVER );
             
               							rect( ( (Group) ( (_GroupData).get(k) )   ).X+((posSketched)* _insideCellWidth),
  									(seqSketched)*_insideCellHeight+( (Group) ( (_GroupData).get(k) )   ).Y,
  									_insideCellWidth, _insideCellHeight); 
Poskeshide++;
             
             

}


else{

  							rect( ( (Group) ( (_GroupData).get(k) )   ).X+((posSketched)* _insideCellWidth),
  									(seqSketched)*_insideCellHeight+( (Group) ( (_GroupData).get(k) )   ).Y,
  									_insideCellWidth, _insideCellHeight); 
Poskeshide++;

}






 }
 else if(rowBased ){   
   
    if(((( (Group)( (_GroupData).get(k) )).SequenceLabelHeader).getColor(j)) == MOUSEOVER && (k==selectedGroupIndex)){
             fill(MOUSEOVER);
             stroke( MOUSEOVER );
              
  //strokeWeight(2);
             
               							rect( ( (Group) ( (_GroupData).get(k) )   ).X+((posSketched)* _insideCellWidth),
  									(seqSketched)*_insideCellHeight+( (Group) ( (_GroupData).get(k) )   ).Y,
  									_insideCellWidth, _insideCellHeight); 
Poskeshide++;
             
 
 }
 
 
 else{
 
   							rect( ( (Group) ( (_GroupData).get(k) )   ).X+((posSketched)* _insideCellWidth),
  									(seqSketched)*_insideCellHeight+( (Group) ( (_GroupData).get(k) )   ).Y,
  									_insideCellWidth, _insideCellHeight); 
Poskeshide++;
 }
 
 
 }
 
			 



  						}
seqSketched++;
    
  						
  					
  				}
 //if(Poskeshide >_density*10)
  posSketched++;
  				
  			}
  }
  
  
    			stroke( SCROLL_BACKGROUND_COLOR );
  			strokeWeight(  SCROLL_LINE_WEIGHT );
  			noFill();
  
  
     if(k == selectedGroupIndex){
  stroke( 0 );
  			
  noFill();
     }
             if(( (Group) ( (_GroupData).get(k) )   ).X > 0 && ( (Group)( (_GroupData).get(k) )).Y >0 ){
                     rect(( (Group) ( (_GroupData).get(k) )   ).X , ( (Group)( (_GroupData).get(k) )).Y, _cellWidth,_cellHeight);
              }
  
  		}
  
  	}
  
  
  //*************** test done
  
  
  
  
  
  	int getViewWidth(){ 
  		return _width;
  	}
  
  	int getViewHeight(){
  		return _height;
  	}
  
  	int getMaxWidth(){
  		return getViewWidth();
  	}
  
  	int getMaxHeight(){
  		return getViewHeight() ;
  	}
  	void renderRowButton(){
  		stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		noFill();
  		rect(0,0,getMaxWidth()/2,_columnLabelHeight);
  		if(rowBased){
  			stroke( BACKGROUND_COLOR );
  			strokeWeight(  SCROLL_LINE_WEIGHT *2);
  			//   fill(255);
  			line(0,_columnLabelHeight,getMaxWidth()/2,_columnLabelHeight);
  		}//if
  		fill( 0);
  		//textFont(_pixel_font_8b);
  		textFont( sans_10 );
  		textAlign( LEFT, BOTTOM );
  		text("Rows",
  				_group_view_origin[0]+ getMaxWidth()/6 , 
  				_group_view_origin[1]+ _columnLabelHeight/2+5
  
  				);
  	}
  	void renderColumnButton(){
  		stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		noFill();
  		rect(getMaxWidth()/2,0,getMaxWidth()/2,_columnLabelHeight);
  		if(!rowBased){
  			stroke( BACKGROUND_COLOR );
  			strokeWeight(  SCROLL_LINE_WEIGHT *2);
  			// fill(255);
  			line(getMaxWidth()/2,_columnLabelHeight,getMaxWidth(),_columnLabelHeight);
  		} //if 
  
  		fill( 0);
  		//textFont(_pixel_font_8b);
  		textFont( sans_10 );
  		textAlign( LEFT, BOTTOM );
  		text("Columns",
  				_group_view_origin[0]+ getMaxWidth()/6 + getMaxWidth()/2, 
  				_group_view_origin[1]+_columnLabelHeight/2+5
  
  				);
  	}
  	void renderCreateGroupButtons(){   
  		stroke( SCROLL_BACKGROUND_COLOR );
  		strokeWeight(  SCROLL_LINE_WEIGHT *2);
  		noFill();
  		rect(_save_button_pos[0],_save_button_pos[1],_button_width, _button_height);
  
  		rect( _save_button_pos[0] -_text_box_width -5 ,_save_button_pos[1],_text_box_width, _text_box_height);  //text_box
  
  //		for(int i=0;i<(_GroupData).size();i++){
  //			rect( _load_button_pos[0] +  , _load_button_pos[1],_button_width, _button_height);
  //		}                
  
  for(int i=0;i<(_GroupData).size();i++){
  
  rect( _load_button_pos[0] + ( (Group)( (_GroupData).get(i) )).X , _load_button_pos[1]+( (Group)( (_GroupData).get(i) )).Y,_button_width, _button_height);
  
  if(i ==loadGroupIndex){
  rect( _load_button_pos[0] + ( (Group)( (_GroupData).get(i) )).X +_button_width/2, _load_button_pos[1]+( (Group)( (_GroupData).get(i) )).Y+ _button_height/2,
  2, 2);
  }
  
  

  
  
  	}
  
 
  }
  	void mousePressedInView( float mx, float my)
  	{
  //		if (mx >= getMaxWidth()/2 && mx<=getMaxWidth() && my>= 0&& my<=_columnLabelHeight ){
  //			rowBased=false;   
  //			selectedGroupIndex=0;   
  //		}
  //		else  if (mx >= 0 && mx<=getMaxWidth()/2 && my>= 0&& my<=_columnLabelHeight ){
  //			rowBased=true;  
  //			selectedGroupIndex=0;    
  //		}
  		saveButtonPressed( mx, my);
  		loadButtonPressed(mx, my);
  		OneGroupPressed(mx, my);
  	}
  
  	boolean  saveButtonPressed(float x, float y){
  		if(x >= _save_button_pos[0] && x<= (_save_button_pos[0]+ _button_width) && y>=_save_button_pos[1] && y<= (_save_button_pos[1] + _button_height)){
  
  			(_GroupData).add(new Group());
  
  			return true;
  		}
  		return false;
  	}
  
  	boolean loadButtonPressed(float x, float y){
  		boolean result=false;
  		// if(loadGroupIndex == -1){
  
  		for(int i=0;i<(_GroupData).size();i++){
  			if(x>= ( _load_button_pos[0] + ( (Group)( (_GroupData).get(i) )).X) && x<= ( _button_width + _load_button_pos[0] + ( (Group)( (_GroupData).get(i) )).X ) 
  					&& y>=_load_button_pos[1]+( (Group)( (_GroupData).get(i) )).Y && y<= (_load_button_pos[1]+( (Group)( (_GroupData).get(i) )).Y+_button_height))
  			{
  				result=true;
  				loadGroupIndex=i;
  				i=  (_GroupData).size(); // so that the loop ends here (faster)
  			}
  		}
  		return result;
  
  	} // loadButtonPressed method
  
  	boolean OneGroupPressed(float x, float y){
  		boolean result=false;
  		for(int i=0;i<(_GroupData).size();i++){
  			if(x>= (( (Group)( (_GroupData).get(i) )).X) && x<= (( (Group)( (_GroupData).get(i) )).X + _cellWidth ) 
  					&& y>= (( (Group)( (_GroupData).get(i) )).Y) && y<= ( (( (Group)( (_GroupData).get(i) )).Y)+_cellHeight))
  			{
  
  				result=true;
  
  				if(i!=selectedGroupIndex){
  					selectedGroupIndex=i;
  					if( selectedGroupIndex !=0)
  					
  statusBarText="A new Group is selected to work with.";
  					if( selectedGroupIndex ==0)
  statusBarText="Backed to original group.";
  					x_start=0;
  					y_start=0;
  				
  if(rowBased){
  
            UpdateInformation();
  }
  }
  
  				i=  (_GroupData).size();
  
  			}
  
  		}
  
  
  		return result;
  	}
  
  	boolean keyPressedInView(){
  		return true;
  	}
  
    void UpdateInformation(){
     
  //   for(int i=0;i<(  ( (Group)( (database._rowGroups).get(selectedGroupIndex) )).PositionHeader     )   . headerSize();i++){ //1404
  //  	(  ( (Group)( (database._rowGroups).get(selectedGroupIndex) )).PositionHeader     )   .setColumnInformation(i,0);
  //} // This was unnesasary because its default is 0
  
  
     for (int j=0;j<(  ( (Group)( (database._rowGroups).get(selectedGroupIndex) )).SequenceLabelHeader).headerSize();j++){ // less than 58
     for(int i=0;i<(  ( (Group)( (database._rowGroups).get(selectedGroupIndex) )).PositionHeader     )   . headerSize();i++){ //1404
     
     if(!database.getNucleotideAtBySeqLabel(   (  ( (Group)( (database._rowGroups).get(selectedGroupIndex) )).SequenceLabelHeader).getHeader(j) ,i).equals("0")){
     	(  ( (Group)( (database._rowGroups).get(selectedGroupIndex) )).PositionHeader).addColumnInformation(i);
    
     }
    }
  }
  
    }
  
  } //GroupView class
  
  
  

