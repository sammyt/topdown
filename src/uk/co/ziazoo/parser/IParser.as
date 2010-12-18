/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 15:57
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public interface IParser
  {
    function get id():String;

    function parse(parserState:ParserState):Result;

    function extractor(extractor:Object):IParser;
  }
}
