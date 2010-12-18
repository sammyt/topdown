/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 15:53
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class ParserState implements IParserState
  {
    private var input:String;
    public var _index:int = 0;
    private var _memoTable:IMemoTable;

    public function ParserState(input:String)
    {
      this.input = input;
      _memoTable = new MemoTable();
    }

    public function at(i:int):String
    {
      return input.charAt(i + _index);
    }

    public function subStr(len:int):String
    {
      return input.substr(_index, len);
    }

    public function subStrFrom(start:int, end:int):String
    {
      return input.substring(start, end);
    }

    public function incr():void
    {
      _index ++;
    }

    public function move(i:int):void
    {
      _index += i;
    }

    public function get len():int
    {
      return input.length - _index;
    }

    public function get memo():IMemoTable
    {
      return _memoTable;
    }

    public function get index():int
    {
      return _index;
    }
  }
}
