/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 16:41
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public interface IParserState
  {
    function at(i:int):String;

    function subStr(len:int):String;

    function incr():void;

    function move(i:int):void;

    function get index():int;

    function get len():int;

    function get memo():IMemoTable
  }
}
