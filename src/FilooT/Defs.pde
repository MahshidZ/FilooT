    //
    // COLORS
    //
    public final color BACKGROUND_COLOR = color( 255 );
    public final color TITLE_COLOR = #1F78B4;
    
    public final color SCROLL_BACKGROUND_COLOR = color( 200 );
    public final color SCROLL_COLOR = color( 150 );
    public final color SCROLL_SELECTED_COLOR = color( 50 );
    
    public final color BORDER_COLOR = color( 150 );
    public final color MOUSEOVER=color(197, 27, 125);
    
    
    public  int DEFAULT_INSIDTE_WIDTH=3;
    public  int DEFAULT_INSIDTE_HEIGTH=2;
    
    
    
    
    public final color[] COLORMAP_1 = { #F7FCF0, // yellow to blue --- GnBu
    		#E0F3DB, 
    		#CCEBC5, 
    		#A8DDB5,
    		#7BCCC4,
    		#4EB3D3,
    		#2B8CBE,
    		#0868AC,
    		#084081 };
    public final color[] COLORMAP_2 = { #FFFFD9, // more yellowish to darker blue --- YlGnBu
    		#EDF8B1, 
    		#C7E9B4, 
    		#7FCDBB,
    		#41B6C4,
    		#1D91C0,
    		#225EA8,
    		#253494,
    		#081D58 };                                    
    public final color[] COLORMAP_3 = { #FFFFCC, // yellow to rust --- YlOrRd
    		#FFEDA0, 
    		#FED976, 
    		#FEB24C,
    		#FD8D3C,
    		#FC4E2A,
    		#E31A1C,
    		#BD0026,
    		#800026 };  
    public final color[] COLORMAP_4 = { #FFFFE5, // more yellowish to darker green --- YlGn
    		#F7FCB9, 
    		#D9F0A3, 
    		#ADDD8E,
    		#78C679,
    		#41AB5D,
    		#238443,
    		#006837,
    		#004529 };  
    public final color[] COLORMAP_5 = { #FFFFE5, // more yellowish to brown --- YlOrBr
    		#FFF7BC, 
    		#FEE391, 
    		#FEC44F,
    		#FE9929,
    		#EC7014,
    		#CC4C02,
    		#993404,
    		#662506 };      
    public final color[] COLORMAP_6 = { #8C510A, // diverging --- BrBG
    		#BF812D, 
    		#DFC27D, 
    		#F6E8C3,
    		#C7EAE5,
    		#80CDC1,
    		#35978F,
    		#01665E };       
    public final color[] COLORMAP_CATAGORICAL = { #FF7F00, 
    		#6A3D9A,
    		#1F78B4, 
    		#33A02C, 
    		#FB9A99,
    		#A6CEE3,
    		#B2DF8A,
    		#FDBF6F,
    		#CAB2D6 };  
  
    public final color SUBCELLS = COLORMAP_5[2];
    public final color NONSUBCELLS =  #CC99CC;
    public final color CORRELATED=#0000CC;
    public final color COMPLEMENTED=#CC0000;
    
    //
    // SIZES
    //
    public static final int WINDOW_BORDER_WIDTH = 30;
    public static final int DIVIDER_LINE_WIDTH = 4;
    
    public static final int SCROLL_WIDTH = 10;
    public static final int SCROLL_OFFSET = 10;
    public static final int SCROLL_LINE_WEIGHT = 1;
    public static final int SCROLL_BAR_LINE_WEIGHT = 5;
    
    public static final int SAVE_LOAD_VIEW_BUTTON_WIDTH=15;
    public static final int SAVE_LOAD_VIEW_BUTTON_HEIGHT=15;
    
    public static final int BORDER_WEIGHT = 1;
    
    //
    // DIMENSIONS
    //
    public static int NUM_NUCLEOTIDES;
    public static int NUM_SEQUENCES;
    public static int NUM_CHARACTERS;
    public static int NUM_REMANINGCOLS;
    float _density=0 ;
    float Pvalue =1;
    Database database;
    // GeneralcellWidth is used in MatrixView Cellwidth. 
    //It is also used to determine the relatove distance between Matrix view and the Main View (matrixview_origin[0])
    int GeneralcellWidth=30; 
    public static int x_start;
    public static int y_start;
    
    float CorrelationStart=0.01;
    float AntiCorrelationStart=-0.4;
     String statusBarText=new String("");
    
    
    public static int selectedGroupIndex=0;
    public static int loadGroupIndex=0;
    public static boolean nutral=true;
    
    	public static int NumberOfVisualizedPositions=17;
        public static int NumberOfVisualizedStrains=12;
        
        int[] lines=new int[1];
    
    
    //
    // GLOBAL (UNCHANGING) VARIABLES
    //
    public static PFont _pixel_font_8;
    public static PFont _pixel_font_8b;
    public static PFont _pixel_font_6b;
    public static PFont _pixel_font_4b;
        public static PFont _pixel_font_2b;
    public static PFont _verdana_font_16;
    public static PFont _verdana_font_8;
    public static PFont _verdana_font_30;
    public static PFont sans_15;
    public static PFont sans_10;
    public static PFont ss;
    
    public static boolean SCROLL_CONDITION=false;
    
    public static Strain[] strains;
    public static Strain originalSeq;
    
    public static Strain[] unfilteredStrains;
    public static color[] _selected_colormap;
    
    
    public static boolean rowBased=true;
    
     int SelectedIndex;
    
    boolean ascend=true;
    
     int[] _align_view_origin=new int[2];
  
       	
    
  Edge[] columnEdges;
  Node[] columnNodes;
  int columnNodeCount;
  int columnEdgeCount;
  HashMap columnRelationshipTable;
  
  Edge[] rowEdges;
  Node[] rowNodes;
  int rowNodeCount;
  int rowEdgeCount;
  HashMap rowRelationshipTable;
  
  
      columnRelation cR;   
      rowRelation rR;   
      Node selection; 
      
       Node selec; 
       Cell CellColumnSelec=null;
      
  	static final color nodeColor   = #777777;
  	static final color selectColor = #FF3030;
  	static final color fixedColor  = #FF8080;
  	static final color edgeColor   = #000000;
     
     	int width_WindowSize=NumberOfVisualizedPositions;
  		int height_WindowSize=NumberOfVisualizedStrains;
 

  int  cellWidth=30;
   int cellHeight= cellWidth;
   int seqLabelHeight=cellHeight;
   int columnLabelWidth=cellWidth;
   
     		float _insideCellWidth=DEFAULT_INSIDTE_WIDTH;
  		float _insideCellHeight=DEFAULT_INSIDTE_HEIGTH;
   
   
   
   int frameColor=SCROLL_BACKGROUND_COLOR*3 ;
   int frameWidth=SCROLL_LINE_WEIGHT *2;
  
   
   //stroke( SCROLL_BACKGROUND_COLOR );
   //strokeWeight(  SCROLL_LINE_WEIGHT *2);

