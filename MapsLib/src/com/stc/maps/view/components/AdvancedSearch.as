package com.stc.maps.view.components
{
	import com.stc.maps.vo.FilterVO;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.LinkButton;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import flash.events.MouseEvent;

	public class AdvancedSearch extends SuperPanel
	{
		private var _searchFilters : ArrayCollection;
		private var searchFiltersChange : Boolean;
		
		private var    pTitleBar:UIComponent;
		private var showSearch : LinkButton = new LinkButton();
		
		public var instructionLabel : String = "Configura tu busqueda y presiona BUSCAR:";
		private var textAreaInstructions : Label = new Label();
		private var searchButton : Button = new Button();
		private var content : VBox = new VBox();
		private var cancelSearchButton : Button = new Button();
		
		private var expanded : Boolean;
		
		public function AdvancedSearch()
		{
			super();
		}

		public function set searchFilters(value : ArrayCollection) : void
		{
			if(value && value.length>0)
			{
				_searchFilters = value;
				searchFiltersChange = true;
				
				invalidateProperties();
			}
		}

		public function get searchFilters() : ArrayCollection
		{
			return _searchFilters;
		}
		
 		override protected function createChildren():void
		{
			super.createChildren();
			
			showSearch.label = "Buscar Ahora";
			
			this.titleBar.addChild(showSearch);
			this.titleBar.setStyle("horizontalAlign","left");
			this.setStyle("horizontalAlign","left");
			textAreaInstructions.setStyle("boderStyle","none");
			//textAreaInstructions.editable = false;
			textAreaInstructions.percentWidth = 100;
			textAreaInstructions.text = instructionLabel;
			//textAreaInstructions.wordWrap = true;
			searchButton.label = "Buscar";
			cancelSearchButton.label = "Ocultar";
			
			cancelSearchButton.addEventListener(MouseEvent.CLICK, cancelSearchButton_click, false, 0, true);
			showSearch.addEventListener(MouseEvent.CLICK, addAllItems, false, 0, true);
			addChild(content);
			
			content.percentWidth = 100;
			
            showSearch.buttonMode       = true;
            showSearch.useHandCursor = true;
            showSearch.width = 100;
            showSearch.height = 22;
            showSearch.x = this.unscaledWidth - showSearch.width;
            showSearch.y = 0;	
		}
		
		private function cancelSearchButton_click(event : MouseEvent) : void
		{
			this.titleBarClickHandler(event);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(searchFiltersChange && expanded)
			{
				searchFiltersChange = false;
				
				content.removeAllChildren();
				content.addChild(textAreaInstructions);
				
				renderSearchForm(searchFilters);
				
				var hbx : HBox = new HBox();
				hbx.percentWidth = 100;
				hbx.addChild(searchButton);
				hbx.addChild(cancelSearchButton);
				hbx.setStyle("horizontalAlign","center");
				hbx.setStyle("horizontalGap","10");
				content.addChild(hbx);
				
				this.setStyle("padding-left","10");
				this.setStyle("padding-right","10");
				this.setStyle("padding-top","10");
				this.setStyle("padding-bottom","10");
				
				this.addEventListener(ResizeEvent.RESIZE, advancedSearch_resize, false, 0, true);
			}
		}
		
		private function addAllItems(event : MouseEvent) : void
		{
			expanded = true;
			invalidateProperties();
		}
		
		private function advancedSearch_resize(event : ResizeEvent)
		{
			if(this.isExpanded)
			{
				this.initPos();
			}
			//this.removeEventListener(ResizeEvent.RESIZE,advancedSearch_resize);
		}
		
		private function renderSearchForm(filters : ArrayCollection) : void
		{
			for each(var filt : FilterVO in filters)
			{
				content.addChild(getTypeRenderer(filt));
			}
		}
		
		private function getTypeRenderer(filt : FilterVO) : UIComponent
		{
			var labelField : Label = new Label();
			labelField.text = filt.label;
			labelField.setStyle("fontWeight","bold");
			var wraper : HBox = new HBox();
			wraper.setStyle("horizontalAlign","left");
			wraper.addChild(labelField);
			wraper.percentWidth = 100;
			
			switch(filt.type)
			{
				case FilterVO.TEXT:
					var txtinpt : TextInput = new TextInput();
					wraper.addChild(txtinpt);
					return wraper;
				break;
				case FilterVO.COMBO:
					var cmb : ComboBox = new ComboBox();
					cmb.dataProvider = filt.options;
					wraper.addChild(cmb);
					return wraper;
				break;
				case FilterVO.MULTIPLE:
					var mult : MultiselectRenderer = new MultiselectRenderer();
					mult.labelOption = filt.label;
					mult.dataProvider = filt.options;
					mult.percentWidth = 100;
					return mult;
				break;
				default:
					var txtinpt : TextInput = new TextInput();
					wraper.addChild(txtinpt);
					return wraper;
				break;
			}
		}
	}
}